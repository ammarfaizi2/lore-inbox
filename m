Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261891AbTCGXsB>; Fri, 7 Mar 2003 18:48:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261897AbTCGXrh>; Fri, 7 Mar 2003 18:47:37 -0500
Received: from adsl-67-120-62-187.dsl.lsan03.pacbell.net ([67.120.62.187]:21265
	"EHLO exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S261891AbTCGXrV>; Fri, 7 Mar 2003 18:47:21 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D1A33DD5@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'Theodore Ts'o'" <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org, linux-newbie@vger.kernel.org,
       Bryan Whitehead <driver@jpl.nasa.gov>
Subject: RE: devfs + PCI serial card = no extra serial ports
Date: Fri, 7 Mar 2003 15:57:56 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 3:39 PM, Theodore Ts'o wrote:
> On Fri, Mar 07, 2003 at 02:51:45PM -0800, Bryan Whitehead wrote:
> > It seems devfsd has an annoying "feature". I bought a PCI 
> > card to get a couple (2) more serial ports. The kernel doesn't 
> > seem to set up the serial ports at boot, so devfs never 
> > creates an entry. However, post boot, since there is no 
> > entries, I cannot configure the serial ports with setserial. 
> > So basically devfsd = no PCI based serial add on?
> 
> Yep.  This I pointed this out as a flaw to devfs a long, long time
> (years!) ago, but Richard chose not to listen to me.  Personally, I
> solve this (and other) problems by simply refusing to use devfs.

Ted,

Will Bryan get the proper devfs entries if he patches serial.c to 
recognize his card at kernel initialization, or is there more 
weirdness expected? 

Best regards,
Ed

---------------------------------------------------------------- 
Ed Vance              edv (at) macrolink (dot) com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------
