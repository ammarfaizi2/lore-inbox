Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264649AbUFOASV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264649AbUFOASV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 20:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264858AbUFOASV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 20:18:21 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:953 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id S264649AbUFOAST convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 20:18:19 -0400
From: "Thomas Gleixner" <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
Organization: linutronix
To: =?iso-8859-1?q?J=F6rn=20Engel?= <joern@wohnheim.fh-wedel.de>,
       Daniel Egger <de@axiros.com>
Subject: Re: jff2 filesystem in vanilla
Date: Tue, 15 Jun 2004 02:12:39 +0200
User-Agent: KMail/1.5.4
Cc: P@draigbrady.com, David Woodhouse <dwmw2@infradead.org>,
       linux-kernel@vger.kernel.org, cijoml@volny.cz
References: <200406041000.41147.cijoml@volny.cz> <213F9E7F-BD15-11D8-AAF6-000A958E35DC@axiros.com> <20040614114526.GA11873@wohnheim.fh-wedel.de>
In-Reply-To: <20040614114526.GA11873@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200406150212.39881.tglx@linutronix.de>
X-Seen: false
X-ID: Z6yQYQZHwe5gm3axMK8e0AFXtqymwiOoZetMYCtgetsLCO6uIVvUE5@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 June 2004 13:45, Jörn Engel wrote:
> In other words, there is absolutely no wear-levelling in either the
> driver or the card itself.  Good to know.

Yep, there is no warranty that wear levelling works by design. Use a CF card 
and mount ext3. Do a bit syslog stuff on it. It will crash over time -  
eXperienced Problems AFAICT.

Using jffs2 via blkmtd minimizes the trouble to a bearable point.

-- 
Thomas
_____________________________________________________________________
>From slash dot org
"When customers are visiting, engineers are not allowed to wear ties. 
That way the customer can tell who is the engineer and who is the 
salesman (and therefore whom to believe.). Ties cut off blood flow 
to the brain, making it easier for the salesmen to do their jobs." 
_____________________________________________________________________
linutronix - competence in embedded & realtime linux
http://www.linutronix.de
mail: tglx@linutronix.de

