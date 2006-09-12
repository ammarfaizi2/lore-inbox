Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbWILF1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWILF1m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 01:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbWILF1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 01:27:42 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:53835 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751204AbWILF1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 01:27:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=G3IW3SQAPigGN5LiLGTh1glO4hT8WO0Qvp+7BS2gBXvHbcwTOedFtl46cKkKuHZuXgYamwdpTFSCFFuy13DUJ6e/fNb5yspudb4dXFArQFmXmnHQHaHaOCjPfyVXd8wBbM8cDrxj+9UuK7CrXPfADYZGUOeaNUM5MPtEaV8Y24E=
Message-ID: <4ae3c140609112227k67aaeb14j3cb39b183934c5a1@mail.gmail.com>
Date: Tue, 12 Sep 2006 01:27:40 -0400
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: question regarding to NFS synchronous writes on metadata
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was told that NFS writes metadata synchronously even if the
directory is exported and mounted with 'async' option. Is this true?
If so, can someone point me to the place where the client write
metadata synchronously to the server and the server writes the
metadata synchronously to the disk?

Many thanks!

-x
