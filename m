Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262103AbUFXBoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262103AbUFXBoF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 21:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263687AbUFXBoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 21:44:04 -0400
Received: from smtp-out2.blueyonder.co.uk ([195.188.213.5]:52599 "EHLO
	smtp-out2.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S262103AbUFXBoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 21:44:02 -0400
Message-ID: <40DA31E0.6010807@blueyonder.co.uk>
Date: Thu, 24 Jun 2004 02:44:00 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RE: what is up with lib64?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Jun 2004 01:44:15.0939 (UTC) FILETIME=[C210C930:01C4598C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cyrus Adkisson wrote:
 > Can someone explain to me why x86_64 has lib64 directories and how 
lib64 is supposed to work with the lib directories that are   > already 
there? I'm having a very difficult time getting anything to compile from 
source.
 >
 > FC2, dual x86_64
lib is for 32-bit and lib64 is for 64-bit obviously. Build success here 
is about 50%, a few build but won't run, segfaults etc.
The configure script in some apps needs the option --libdir=/usr/lib64 
e.g. there is also a /lib64 and /usr/X11R6/lib64. Some apps will 
configure and build without the need to adjust options. Some others will 
not build as distributed, e.g kmymoney which keeps looking in /usr/lib 
instead of /usr/lib64. There are yet others like slmodem that contain a 
32-bit proprietary module for 2.4.x that will not be compatible with  
2.6.x kernel sources.
Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
===== LINUX ONLY USED HERE =====

