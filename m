Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130792AbQKGD7b>; Mon, 6 Nov 2000 22:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130896AbQKGD7V>; Mon, 6 Nov 2000 22:59:21 -0500
Received: from web3707.mail.yahoo.com ([204.71.203.136]:32013 "HELO
	web3707.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S130792AbQKGD7L>; Mon, 6 Nov 2000 22:59:11 -0500
Message-ID: <20001107035905.18154.qmail@web3707.mail.yahoo.com>
Date: Mon, 6 Nov 2000 19:59:05 -0800 (PST)
From: RAJESH BALAN <atmproj@yahoo.com>
Subject: malloc(1/0) ??
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
why does this program works. when executed, it doesnt
give a segmentation fault. when the program requests
memory, is a standard chunk is allocated irrespective
of the what the user specifies. please explain.
 
main()
{
   char *s;
   s = (char*)malloc(0);
   strcpy(s,"fffff");
   printf("%s\n",s);
}

NOTE:
  i know its a 'C' problem. but i wanted to know how
this works 


__________________________________________________
Do You Yahoo!?
Thousands of Stores.  Millions of Products.  All in one Place.
http://shopping.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
