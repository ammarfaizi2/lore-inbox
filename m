Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263250AbTDLMAK (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 08:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263251AbTDLMAJ (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 08:00:09 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:53669 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263250AbTDLMAJ (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 12 Apr 2003 08:00:09 -0400
Date: Sat, 12 Apr 2003 13:11:32 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: "Shaheed R. Haque" <srhaque@iee.org>
Cc: linux-kernel@vger.kernel.org, thockin@isunix.it.ilstu.edu
Subject: Re: Processor sets (pset) for linux kernel 2.5/2.6?
Message-ID: <20030412121127.GA21215@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	"Shaheed R. Haque" <srhaque@iee.org>, linux-kernel@vger.kernel.org,
	thockin@isunix.it.ilstu.edu
References: <1050146434.3e97f68300fff@netmail.pipex.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1050146434.3e97f68300fff@netmail.pipex.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 12, 2003 at 12:20:35PM +0100, Shaheed R. Haque wrote:

 > announcing an updated patch in April 1999. Are there any plans out there to 
 > include this, or similar functionality in 2.5/2.6? I'm particularly interested 
 > in getting exclusive access to a CPU (plus or minus HT support, for now anyway).

sched_getaffinity() and sched_setaffinity()
You'll also need schedutils from http://tech9.net/rml/schedutils

all this (and more) documented at http://www.codemonkey.org.uk/post-halloween-2.5.txt

		Dave
