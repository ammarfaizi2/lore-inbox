Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290350AbSAPEOg>; Tue, 15 Jan 2002 23:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290353AbSAPEO1>; Tue, 15 Jan 2002 23:14:27 -0500
Received: from nycsmtp1out.rdc-nyc.rr.com ([24.29.99.226]:24032 "EHLO
	nycsmtp1out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S290346AbSAPEOW>; Tue, 15 Jan 2002 23:14:22 -0500
Message-ID: <3C44FE0E.9010604@nyc.rr.com>
Date: Tue, 15 Jan 2002 23:14:06 -0500
From: John Weber <weber@nyc.rr.com>
Organization: WorldWideWeber
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, grant@torque.net
Subject: linux 2.5 and ppa.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is one of those drivers still broken due to the BIO changes
(it still calls io_request_lock()).

Unfortunately, I only know enough to
s/io_request_lock/host->host_lock/g.

I am afraid this requires a little more than this.

What's the status on this?
Just a heads up...

