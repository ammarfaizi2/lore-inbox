Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266223AbUHRNHd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266223AbUHRNHd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 09:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266303AbUHRM6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 08:58:01 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:42770 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S266319AbUHRM4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 08:56:02 -0400
Message-ID: <412352C9.7090006@hist.no>
Date: Wed, 18 Aug 2004 14:59:53 +0200
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Janusz Dziemidowicz <rraptorr@kursor.pl>
CC: Diego Calleja <diegocg@teleline.es>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] ext3 documentation (lack of)
References: <20040818025951.63c4134e.diegocg@teleline.es> <200408172301.09350.ryan@spitfire.gotdns.org> <20040818133818.7b0582f3.diegocg@teleline.es> <Pine.LNX.4.61.0408181414450.18542@stacja.kursor.pl>
In-Reply-To: <Pine.LNX.4.61.0408181414450.18542@stacja.kursor.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Janusz Dziemidowicz wrote:

> AFAIK
> user_xattr - turns on POSIX Extended attributes
> nouser_xattr - obvious
> acl - turns on ACL (Access Control Lists)
> noacl - obvious
>
> However these features are only present in 2.6.x, they are explained 
> in Help during kernel configuration. I'm not sure if acl requires 
> user_xattr to be turned on. I remember that I spent some time looking 
> for a way to enable these on ext2/ext3 :)

ACL's does not require use of the user_xattr mount option - I have tested
that acl's work on ext3 with only the "acl" option.  I guess user_xattr is
turned on automatically as needed - you can use the option if you want
posix extended attributes without acls.

Helge Hafting
