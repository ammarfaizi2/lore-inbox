Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbVAMFsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbVAMFsK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 00:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVAMFsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 00:48:10 -0500
Received: from rproxy.gmail.com ([64.233.170.207]:5816 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261164AbVAMFsI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 00:48:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=XRMuNaGcqdr6p7uWcT45ampnx/yElRWeraUoTuL63w+GxenfX+JHS+7WFOTpJIjl9QsSPVY5PGLfOfBQNql5SEv9uzlZId0pmNv8tozCGrgDzk4vFoETOU76uuaJ6XLQtjxVAJmnMRaIgOj+9aGzZvLiPM8LIyXIGEL41HgtjZw=
Message-ID: <1458d96105011221482cdae349@mail.gmail.com>
Date: Thu, 13 Jan 2005 11:18:07 +0530
From: Sumit Narayan <talk2sumit@gmail.com>
Reply-To: Sumit Narayan <talk2sumit@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Linux Buffer Sync
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am working with a disk at block level and have coded my own device
driver. I do not use any file system on it, its a raw write disk. I
however wish to use the linux buffer caching system to implement it. I
require to sync my data(buffer) on the disk everytime I wish to; i.e.,
I should have complete control over the buffer and should be able to
sync my data with the disk when I wish to.

Could someone tell me how this could be done?

Thanks in advance,
Sincerely,
Sumit
