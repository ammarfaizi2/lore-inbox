Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265034AbSKVCc7>; Thu, 21 Nov 2002 21:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265059AbSKVCc7>; Thu, 21 Nov 2002 21:32:59 -0500
Received: from mail-02.iinet.net.au ([203.59.3.34]:40978 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id <S265034AbSKVCc7>;
	Thu, 21 Nov 2002 21:32:59 -0500
Message-ID: <3DDD7CB9.4050001@iinet.net.au>
Date: Fri, 22 Nov 2002 11:39:21 +1100
From: Nero <neroz@iinet.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [BUG] Qt 3.1 and xconfig
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason this didn't get to the list last time I sent it, so here 
it is again:

If you link against qt 3.1 (and this will be common soon, KDE 3.1
requires it), you can't change any of the options. There is a warning
when it is running:

QObject::connect: No such signal ConfigList::menuSelected(struct menu*)
QObject::connect:  (sender name:   'unnamed')
QObject::connect:  (receiver name: 'unnamed')
QObject::connect: No such signal ConfigList::menuSelected(struct menu*)
QObject::connect:  (sender name:   'unnamed')
QObject::connect:  (receiver name: 'unnamed')



