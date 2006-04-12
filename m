Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbWDLRtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbWDLRtR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 13:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWDLRtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 13:49:17 -0400
Received: from smtpq1.tilbu1.nb.home.nl ([213.51.146.200]:47236 "EHLO
	smtpq1.tilbu1.nb.home.nl") by vger.kernel.org with ESMTP
	id S932289AbWDLRtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 13:49:14 -0400
Message-ID: <443D3DED.5030009@keyaccess.nl>
Date: Wed, 12 Apr 2006 19:50:37 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Dmitry Torokhov <dtor_core@ameritech.net>
CC: Jean Delvare <khali@linux-fr.org>, Takashi Iwai <tiwai@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Is platform_device_register_simple() deprecated?
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, Russel, Dmitry.

ALSA is using platform_device_register_simple(). Jean Delvare pointed:

http://marc.theaimsgroup.com/?l=linux-kernel&m=113398060508534&w=2

out, where _simple looks to be slated for removal. Is this indeed the 
case? ALSA isn't using the resources -- doing a manual alloc/add would 
not be a problem...

Rene.





