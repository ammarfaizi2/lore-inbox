Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282611AbRKZW0O>; Mon, 26 Nov 2001 17:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282609AbRKZW0E>; Mon, 26 Nov 2001 17:26:04 -0500
Received: from tomts15.bellnexxia.net ([209.226.175.3]:46466 "EHLO
	tomts15-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S282611AbRKZWZw>; Mon, 26 Nov 2001 17:25:52 -0500
Content-Type: text/plain; charset=US-ASCII
From: Nav Mundi <nmundi@karthika.com>
To: linux-kernel@vger.kernel.org
Subject: Intercept block device calls
Date: Mon, 26 Nov 2001 17:25:22 -0500
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011126222547.NQVM14865.tomts15-srv.bellnexxia.net@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I'm trying to create a module that will:

1) intercept System Calls to a Block Device (i.e. no direct communications 
between the Application and Block Device) and instead
2) Communicate directly with a Block Device without interference from other 
layers.

In other words, the module will effectively hide all direct communication 
between the application and block device.

Please advice.

Thanks
-Nav

