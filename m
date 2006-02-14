Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750867AbWBNCQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbWBNCQt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 21:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbWBNCQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 21:16:49 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:28092 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750867AbWBNCQs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 21:16:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=c7bW4U+lurU9oDuhmWZb1zSHjweuBsTYdJkgb6U6KMWzQRTK6ioFiFNeHJ/ZPifaXv4jPL2A1s1Ox9wq40i4Z25zrsdTxI7XhiZEnzc2zfMoNgmnjYaSmzQNHWlt7Ewv/gQZZ9ubUWUtI36ITnn1mHmAX0AvEWaOwhgwnItiBnU=
Message-ID: <787b0d920602131816p3e1ffa73m19134fc4322e6e09@mail.gmail.com>
Date: Mon, 13 Feb 2006 21:16:47 -0500
From: Albert Cahalan <acahalan@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: __WALL and WNOWAIT
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why can't I use both of these?

Both wait4() and waitid() seem to be needlessly restricted.
Neither is a superset of the other in terms of flags accepted.
