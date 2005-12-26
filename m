Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbVLZUrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbVLZUrN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 15:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbVLZUrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 15:47:13 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:47204 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932142AbVLZUrM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 15:47:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=i240gOc70WIcUA1iOZpx6/dW6JPNSTJdK4iKhHPetUtCBKQ+LJOZMYMBzeI2aWYoee8VngxfFQ1Ca6a8IRz34oKdhSVc3/qdvV43PCJ1VQOItvyoMElsJ/4Jg88UFzniv9m+KDKq4KytFbhfLYqeuPqQjwmH0nwgvNwH0c2g9ZQ=
Message-ID: <4ae3c140512261247p612146f5w6ad8bf474f4ebfd5@mail.gmail.com>
Date: Mon, 26 Dec 2005 15:47:11 -0500
From: Xin Zhao <uszhaoxin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Is there any Buffer overflow attack mechanism that can break a vulnerable server without breaking the ongoing connection?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are working on a mechanism that monitors the connections of a
server and detects potential intrusions via broken connection
(incoming request received, but no reply).  We want to thoroughly
understand the possibility of mounting a buffer overflow attack
against a server process without cutting off the connection.

Any insight on this?

Thanks in advance!

Xin
