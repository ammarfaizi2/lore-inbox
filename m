Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129084AbREGEYw>; Mon, 7 May 2001 00:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135508AbREGEYm>; Mon, 7 May 2001 00:24:42 -0400
Received: from mx9.port.ru ([194.67.23.46]:37876 "EHLO mx9.port.ru")
	by vger.kernel.org with ESMTP id <S129084AbREGEY3>;
	Mon, 7 May 2001 00:24:29 -0400
From: "Samium Gromoff" <_deepfire@mail.ru>
To: "Chris Mason" <mason@suse.com>
Cc: linux-kernel@vger.kernel.org, reiser@idiom.com, monstr@namesys.com
Subject: Re[2]: Q: HowTo Nullify journal on badblks?
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [195.34.27.33]
In-Reply-To: <242950000.988312820@tiny>
Reply-To: "Samium Gromoff" <_deepfire@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E14wcZQ-000CR4-00@f12.port.ru>
Date: Mon, 07 May 2001 08:24:28 +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

         Hello busy peoples, again me...
      Today got my 45gb drive slightly badblocked:
   about 70 MB in beginning... thus problem arose:
   bitmaps are heavily corrupted, and debugreiserfs  
   with -p crashes while trying to dump journal
   (he`s not alone in such behaviour: evryone doing
    that fails with Segfault). I need to dump
   all metadata to refresh bitmaps etc, but i can`t.
   
   3.x.0j-pre2/linux-2.4.4

   what do i have to do?

   i can provide a strace of segfaulted --fix-fixable
            thanks in advance        
