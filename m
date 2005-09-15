Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030399AbVIONGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030399AbVIONGL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 09:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030403AbVIONGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 09:06:11 -0400
Received: from web8404.mail.in.yahoo.com ([202.43.219.152]:32639 "HELO
	web8404.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S1030399AbVIONGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 09:06:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=HVQI+7dtNDlGMvhC1nKGi94iJOZv+5jzHYdJhnzbhF8HRFL88h0NxL5Bx0Jy4ngTtgKlFhBsQG7tt2L9Uy3lKNy/ecpdQuOdWK5iutMZjNi1ZpMfa5VOc83u5i8Tr1/sxqmOdt7rr9EF1InJk8fEGHN4g59IM/iwxrtcflk9iaY=  ;
Message-ID: <20050915130607.56132.qmail@web8404.mail.in.yahoo.com>
Date: Thu, 15 Sep 2005 14:06:07 +0100 (BST)
From: shashank kharche <shashank_pict@yahoo.com>
Subject: Problem in writing simple block device driver...
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have written a simple block device driver in which i
m just displaying messages
in read & write part e.g " Device Reading .... " &  "
Device Writing .....".
I have succesfully loaded that module in memory using
"insmod" . 
& then use " mknod " command ...as   : 

                   mknod block_dev b 100 0 
  where , block_dev : name of device
                  b : as i m using block device driver
                100 : major number
                  0 : minor number
   
Even this is also working without error, now after
this command device "block_dev" is created (i have
checked it wit ls command ).
But , now while using "cat" & "echo" i am getting
error as :
       
       [root@localhost root]# cat block_dev
       cat: block_dev : No such device or address

       [root@localhost root]# echo "hello" > block_dev
       bash: block_dev : No such device or address
               
Is it ok to use 'b' in mknod command while working
with block device driver,
as i hav used (shown above).

Im attaching C-code also,so plz help me....if you have
another simple code for block device driver please
send me : shashank_pict@yahoo.com 

Please tell me what is going wrong in this code.....



		
__________________________________________________________ 
Yahoo! India Matrimony: Find your partner now. Go to http://yahoo.shaadi.com
