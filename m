Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288208AbSACEvM>; Wed, 2 Jan 2002 23:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288210AbSACEvC>; Wed, 2 Jan 2002 23:51:02 -0500
Received: from nycsmtp1out.rdc-nyc.rr.com ([24.29.99.226]:6051 "EHLO
	nycsmtp1out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S288208AbSACEuo>; Wed, 2 Jan 2002 23:50:44 -0500
Message-ID: <3C33E319.5010206@nyc.rr.com>
Date: Wed, 02 Jan 2002 23:50:33 -0500
From: John Weber <weber@nyc.rr.com>
Organization: WorldWideWeber
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: More errors compiling kernel with GCC 3.1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm just trying to read the source code, and I am having trouble in a 
few areas.  For example, I am completely baffled by the number of macros 
that get called in some places.  For example, in the semaphore code... 
just wondering why DECLARE_MUTEX (macro) calls DECLARE_SEMAPHORE_GENERIC 
(macro) calls SEMAPHORE_INITIALIZER (macro) calls 
WAIT_QUEUE_HEAD_INITIALIZER (macro) and so on, and so on...

I guess I can understand the use of a macro to deal with the overhead
introduced by calling functions all over the place, but having this
many macros that call macros isn't clear to me... I just hope that it
wasn't done to make the code easier to read or something :).

Can anyone point me to some documentation that might explain this type 
of thing?

