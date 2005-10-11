Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbVJKUXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbVJKUXK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 16:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbVJKUXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 16:23:10 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:18874 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751217AbVJKUXI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 16:23:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=t6BRezmGHy3hkd307PZcKqNQwaMtGtiItpdzStnkaZKD0dW60AEx89gy3Jr32hOHT4k8iZ+fF9PDaCJMEcqVMn9Dar9FnlK4x3R2wOfDa9K9j/pc/VPVROPiTkYxbaKDRu1usIAJPM9l4nLoV4OmObI+HMQJPfCn68t7tHLSfWc=
Message-ID: <434C1F23.7020702@gmail.com>
Date: Wed, 12 Oct 2005 05:22:59 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] matchreply (deliver mails into folders with associated
 threads)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Hello, all.

  This isn't really linux kernel related but I wrote this to track LKML 
discussion threads better and I hope this can make following LKML a 
little bit easier for others too.

  What matchreply does is to enable procmail to deliver a message into 
the folder containing its associated thread.  So, when you find an 
interesting thread on LKML, just move the thread into your 'interested' 
folder, and then all follow-up messages will be delievered there.

  matchreply assumes Maildir format folders and uses inotify, so you 
need kernel version >= 2.6.13.

  README (explains how to setup .procmailrc) is at

http://home-tj.org/matchreply/files/README

  Source tarball

http://home-tj.org/matchreply/files/matchreply-0.1.tar.gz

  Binaries for i386 and x86_64

http://home-tj.org/matchreply/files/binary-matchreply-0.1-i386
http://home-tj.org/matchreply/files/binary-matchreply-0.1-x86_64

  Thanks.

-- 
tejun
