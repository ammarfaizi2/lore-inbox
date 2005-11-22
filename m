Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964997AbVKVQrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964997AbVKVQrj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 11:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965000AbVKVQrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 11:47:39 -0500
Received: from p-mail1.rd.francetelecom.com ([195.101.245.15]:17167 "EHLO
	p-mail1.rd.francetelecom.com") by vger.kernel.org with ESMTP
	id S964997AbVKVQri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 11:47:38 -0500
Message-ID: <43834BA3.8090406@francetelecom.com>
Date: Tue, 22 Nov 2005 17:47:31 +0100
From: VALETTE Eric RD-MAPS-REN <eric2.valette@francetelecom.com>
Reply-To: eric2.valette@francetelecom.com
Organization: Frnace Telecom R&D
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steve French <smfrench@austin.rr.com>
CC: linux-kernel@vger.kernel.org, torvalds@osdl.com
Subject: Re: CIFS improvements/wider testing needed
References: <4381EFF3.8000201@austin.rr.com> 	<4382032D.4080606@francetelecom.com> <43823BF0.5050408@austin.rr.com> 	<4382E2A7.7080100@francetelecom.com> <43834052.4090509@austin.rr.com>
In-Reply-To: <43834052.4090509@austin.rr.com>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Nov 2005 16:47:31.0860 (UTC) FILETIME=[6E810D40:01C5EF84]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve French wrote:

>>This makes me *really* wonder how you test your CIFS implementation.  I
>>would bet you use a Linux server with samba and not real Windows servers
>>like Windows 2000 server or Windows 2003 server. I can perfectly
>>understand that for development purpose because you can tarce the both
>>side, then for validation I think using WindoWS NT (Ok Obsolete but
>>still), Windows 2000 server or Windows 2003 server is mandatory.

> There are two big test events for CIFS each year (Connectathon and the
> SNIA CIFS conference) in which all of the major CIFS vendors servers and
> clients (including the Linux cifs client) are tested together.   These
> two events has been the most helpful for me every year as they are for
> many others on the Samba team (lots of Samba server progress also
> happens in these two weeks).   That is the best opportunity (almost the
> only good opportunity) for testing against EMC, NetApp, Adaptec/SNAP,
> AIX FastConnect, and the other NAS vendors - and at each event a few
> client bugs have been fixed or client workarounds for server bugs have
> been added as a result of this testing.   For weekly testing there are
> of course more test environments than mine, and I get feedback from
> those testing against other server versions, but I have a small test
> environment at home and also one at work (there are other unrelated test
> groups that test the version of cifs and Samba before distro releases)
> that I regularly test against.  It would be impossible for one person to
> test against the breadth of servers out there so community testing,
> especially against the less well known servers, is encouraged.  

That is great that such "plug fest" exists and I agree with you that
this is the only way to test compatibility to such scale.

> In my test environment these are tested almost daily as target servers:
> 
> 1) Samba version 3 (current)
> 2) Windows XP service pack 2


Do you have collected any statistics on Windows server market share per
windows version? I would bet 2000 Server is still mainstream with 2003
slowly replacing NT4 in term of percentage now that support is stopped.

Idealy, may I suggest that dayly testing platforms, should match this
real life Winddows server platform distribution.


-- eric
