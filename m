Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314389AbSEYJ4B>; Sat, 25 May 2002 05:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314417AbSEYJ4A>; Sat, 25 May 2002 05:56:00 -0400
Received: from sisko.nothing-on.tv ([213.208.99.114]:3857 "EHLO
	sisko.nothing-on.tv") by vger.kernel.org with ESMTP
	id <S314389AbSEYJz7>; Sat, 25 May 2002 05:55:59 -0400
From: Tony Hoyle <tmh@nothing-on.tv>
Subject: Re: can't find startup messages since april in /var/log/messages using 2.4.18
Date: Sat, 25 May 2002 10:57:42 +0100
Organization: cvsnt.org news server
Message-ID: <pan.2002.05.25.09.57.42.627828.10526@nothing-on.tv>
In-Reply-To: <3a.2744d23a.2a20b7ec@aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: sisko.nothing-on.tv 1022320558 5591 213.208.99.115 (25 May 2002 09:55:58 GMT)
X-Complaints-To: abuse@cvsnt.org
User-Agent: Pan/0.11.3 (Unix)
X-Comment-To: "Floydsmith" <Floydsmith@aol.com>
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 May 2002 10:52:31 +0100, Floydsmith wrote:


> For some strange reason I can't find where my "startup messagges" are
> being stored. I booted up twice this morning (052502) and only get only
> 1 line in /var/log/messages which is: May 25 05:10:05 localhost syslogd
> 1.3-3: restart.
> 
> All boots since April 11 have only one such entry recorded. "dmesg" and
> a "vi" of "messages" show a full log journal for April 11. I have did a
> "df" and all file sytems have free space.
> 
> Of course, the meesages do appear on the console at startup.
> 
> Any suggestions?
> 
Look in /var/log/messages.0

I have a machine that does this - exactly the same config as every other
machine but it insists of logging to the backup files.

Tony

