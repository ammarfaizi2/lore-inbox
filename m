Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261421AbUE0Fip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbUE0Fip (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 01:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbUE0Fip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 01:38:45 -0400
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:30309 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261421AbUE0Fim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 01:38:42 -0400
Message-ID: <40B57EDF.8060405@yahoo.com.au>
Date: Thu, 27 May 2004 15:38:39 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Matthias Schniedermeyer <ms@citd.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: why swap at all?
References: <S265353AbUEZI1M/20040526082712Z+1294@vger.kernel.org> <40B4590A.1090006@yahoo.com.au> <200405260934.i4Q9YblP000762@81-2-122-30.bradfords.org.uk> <40B467DA.4070600@yahoo.com.au> <20040526101001.GA13426@citd.de> <40B47278.6090309@yahoo.com.au> <20040526105837.GA13810@citd.de> <40B47D4C.6050206@yahoo.com.au> <20040526122705.GA14320@citd.de>
In-Reply-To: <20040526122705.GA14320@citd.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Schniedermeyer wrote:
> On Wed, May 26, 2004 at 09:19:40PM +1000, Nick Piggin wrote:

>>OK, this is obviously bad. Do you get this behaviour with 2.6.5
>>or 2.6.6? If so, can you strace the program while it is writing
>>an ISO? (just send 20 lines or so). Or tell me what program you
>>use to create them and how to create one?
> 
> 
> program: mkisofs
> kernel: 2.4.4-2.4.25, 2.6.4-2.6.6
> (To say it in other words, i never (seen/felt) a difference in 3 years.
> So if there is a difference i just didn't realized there is one)
> The current kernel is 2.6.5 as 2.6.6 sometimes just "hangs"
> 
> Just throw together some lage files (My files are all >= 350MB, the
> "typical" case is about 4-5files with 800-1000MB each) and then
> mkisofs -J -r -o <image> <source-dir>
> I store the image files on another HDD to get best possibel throughput.
> My HDDs (these are "normal" IDE-HDDs) are capable of delivering about
> 35-40MB/s, the last time i measured i got about 70MB/s aggregated
> throughput while creating an image-file.
> 

Thanks. I'll see if I can reproduce.
