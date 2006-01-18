Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030370AbWARQPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030370AbWARQPw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 11:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030369AbWARQPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 11:15:52 -0500
Received: from allen.werkleitz.de ([80.190.251.108]:21155 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S1030370AbWARQPu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 11:15:50 -0500
Date: Wed, 18 Jan 2006 17:15:06 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Jean Delvare <khali@linux-fr.org>, Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20060118161506.GA13625@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Sam Ravnborg <sam@ravnborg.org>, Jean Delvare <khali@linux-fr.org>,
	Eyal Lebedinsky <eyal@eyal.emu.id.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org> <43CD67AE.9030501@eyal.emu.id.au> <20060117232701.GA7606@mars.ravnborg.org> <20060118085936.4773dd77.khali@linux-fr.org> <20060118091543.GA8277@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060118091543.GA8277@mars.ravnborg.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: 84.190.176.201
Subject: Re: Linux 2.6.16-rc1
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006, Sam Ravnborg wrote:
> echo "main() {}" | gcc -xc - -o /dev/null
> 
> And it seems that gcc will trash /dev/null in your setup when doing
> this.

gcc -o /dev/null is also used by cc-option and in some other
places (at least in 2.6.15). (For me this doesn't trash the
device node, it just gives it execute permission.)

Johannes
