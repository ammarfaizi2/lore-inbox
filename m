Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751355AbWGRQQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbWGRQQV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 12:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWGRQQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 12:16:21 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:44313 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751355AbWGRQQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 12:16:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=JI6T9QAmlX9ezq0OZwGaAcO4ZuaShDG1G3Mv5faBmE5C9jGn231LI9ghZscivpdM76PMeeq5TfYexY/7UDvbqPskMHooqcE/NmU2wTGNPwJLPIrVtVdBtu9j3xCXI0CTXtYce+ObDKJ/AjNiQ2Zh0PIjRjo0ZCkxFU8hyLcZieY=
Message-ID: <17d79880607180916h6c6d63ddo2f5a6d090fa53c7f@mail.gmail.com>
Date: Tue, 18 Jul 2006 12:16:16 -0400
From: Allison <fireflyblue@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: snapshot of physical memory
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am interested in getting a snapshot of the linux physical memory to
perform some offline analysis on it. I read in another post that I can
simply copy /dev/mem and it copies all physical memory contents. It
indeed gave me the same file size as the amount of physical memory
Linux recognizes.

1. Is my understanding correct ? What are the other ways one can dump
physical memory.I am interested in taking a snapshot of memory.

2. How do I make sure that no updates take place in memory from the
time I initiate the snapshot till it is done.

3. What is the best way to find out whether each page in here belongs
to kernel or process memory.. also the type of page (code,data etc)

4. What exactly happens when you copy /dev/mem to a file.

I am not an expert in this area. Detailed answers are greatly
appreciated.

thanks,
Allison
