Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262446AbVBYFAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbVBYFAc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 00:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262494AbVBYFAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 00:00:32 -0500
Received: from rproxy.gmail.com ([64.233.170.206]:24796 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262446AbVBYFA2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 00:00:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=UHQXv072CMHz4VVo2qrlfDn3TGEvCohNRiJiW8AvTW+y7jZZ+L1Bxn7jkM2IyF/Fl9OAkW6VTkTJMSiE0VfN46Id+MgsO232j4lKt6bmAmiuLg1oTjakn5QtZQYx9lmKKHXUZOJ8eAtFLJDgHvnxJmIld2NBFqzhuFbiy7vh5Dw=
Message-ID: <1458d96105022421001e006f5f@mail.gmail.com>
Date: Fri, 25 Feb 2005 10:30:27 +0530
From: Sumit Narayan <talk2sumit@gmail.com>
Reply-To: Sumit Narayan <talk2sumit@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: USB IDE Connector
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have an external IDE connector through USB port. Where could I get
the exact point inside the kernel, from where I would get information
such as Block No., Request size, partition details for a particular
request, _just_ before being sent to the disk.

Like, for a normal IDE, I could gather these details from inside the
function __ide_do_rw_disk from "struct request". Is there anyway for
finding out the same for a USB mass storage device?

Thanks.
