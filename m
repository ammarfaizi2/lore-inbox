Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936207AbWK3LLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936207AbWK3LLJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 06:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936208AbWK3LLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 06:11:08 -0500
Received: from wr-out-0506.google.com ([64.233.184.238]:43067 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S936207AbWK3LLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 06:11:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=cVMVHOLa1xYIiKiWRgDqTyc2lW4MSesp1GfQ60ucswrcpJ8WxYhDkrkbyGQv065spZNyLtHShx7Q1T0KJqmoynkHLJNq1P4mQIkdnw/IF/2LEQZ9Vomd1ayi5cgSl5Yu7N86lzBr4OIr7ZUeeKcCs/gnqftJDJTc2W9QRffPdOc=
Message-ID: <e7aeb7c60611300311r7763322at6d833551526c2d76@mail.gmail.com>
Date: Thu, 30 Nov 2006 13:11:06 +0200
From: "Yitzchak Eidus" <ieidus@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: splitting work between user space program and the kernel
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i am looking to write a cluster program to linux.
each linux node will have to be connected in the network to other node.
in each node the kernel will have to know the "network information"
since i dont want to do the network work in the kernel and i want it
to be done in user space, i ask what is the best way to split the work
between the kernel and user space application that will interact with
each other...?
thanks
Yitzchak Eidus
