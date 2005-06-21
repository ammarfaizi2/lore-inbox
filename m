Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbVFUPoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbVFUPoW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 11:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbVFUPmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 11:42:07 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:25243 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262128AbVFUPky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 11:40:54 -0400
Subject: Re: IBM HDAPS Someone interested?
From: Lee Revell <rlrevell@joe-job.com>
To: Adam Goode <adam@evdebs.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Pavel Machek <pavel@suse.cz>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       linux-kernel@vger.kernel.org, linux-thinkpad@linux-thinkpad.org
In-Reply-To: <1119303016.5194.24.camel@lynx.auton.cs.cmu.edu>
References: <20050620155720.GA22535@ucw.cz>
	 <005401c575b3_5f5bba90_600cc60a@amer.sykes.com>
	 <20050620163456.GA24111@ucw.cz> <20050620165703.GB477@openzaurus.ucw.cz>
	 <20050620204533.GA9520@ucw.cz>
	 <1119303016.5194.24.camel@lynx.auton.cs.cmu.edu>
Content-Type: text/plain
Date: Tue, 21 Jun 2005 11:37:38 -0400
Message-Id: <1119368259.19357.18.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-20 at 17:30 -0400, Adam Goode wrote:
> Freefall detection: 300 ms
> Head park time: 300-500 ms
>   (from page 2 of document)
> 
> Still doesn't seem too bad to figure out how to code though, at least
> once we can figure out how to get the data stream!
> 
> P.S. The main control system runs as a Windows kernel driver. Not as
> safe as full hardware, but probably better than userspace. :)
> 

Ugh, if userspace can't meet a 300ms RT constraint, that's a pretty
shitty OS you have there.

This should certainly be done in userspace on Linux.

Lee

