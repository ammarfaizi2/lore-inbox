Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314347AbSDRRfg>; Thu, 18 Apr 2002 13:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314377AbSDRRff>; Thu, 18 Apr 2002 13:35:35 -0400
Received: from mail.myrio.com ([63.109.146.2]:28145 "HELO mail.myrio.com")
	by vger.kernel.org with SMTP id <S314347AbSDRRfe> convert rfc822-to-8bit;
	Thu, 18 Apr 2002 13:35:34 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: VM Related question
Date: Thu, 18 Apr 2002 10:35:04 -0700
Message-ID: <A015F722AB845E4B8458CBABDFFE63420FE3D7@mail0.myrio.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: VM Related question
Thread-Index: AcHmuryv7OX9yNE4Sdy8yebHu2vYyQAQ7m4Q
From: "Torrey Hoffman" <Torrey.Hoffman@myrio.com>
To: "Tony Clarke" <sam@palamon.ie>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 18 Apr 2002 17:34:19.0279 (UTC) FILETIME=[450FB1F0:01C1E6FF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Clarke wrote:

> I have noticed with my current kernel that after the system 
> is idle for 
> a while, say 10 hours or
> so, that everything seems to be swapped out to disk. So when 
> I come in 
> the next morning
> it starts swapping everything like crazy in from disk. 

Probably what is happening is that in the middle of the night,
your distribution runs a cron job like "slocate" or "medusa"
which scans through your hard drive.  Other distros do security
checks for world-writable files and many other things...

This heavy read activity fills up a lot of buffers and causes 
your apps to be swapped out. 

Torrey

thoffman@arnor.net

