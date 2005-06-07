Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261879AbVFGQhM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbVFGQhM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 12:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbVFGQhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 12:37:12 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:8871 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261879AbVFGQhI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 12:37:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Jmx0Mtm9+t+CgC54xAZuJeYJAsckU6Dhk5x0P5g3qjLmHSvMVDKJnYHurEx8DDQvt9ukJGebLQ6yhLYJzOoyddlluHkubrdd4eFmD7nQQ1Leu+hIvJR50uTJu67/pRF4+yblLCeBiOD2dz0biMgyoz3jE5RfS7FeB9eljKsCkbc=
Message-ID: <6e8f964d050607093729e66ae0@mail.gmail.com>
Date: Tue, 7 Jun 2005 12:37:08 -0400
From: Thummal <pthummal@gmail.com>
Reply-To: Thummal <pthummal@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Strange S3 resume (2.6.11.11) problem with sata device.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I applied the patches provided by Jens Axboe to resolve disk hang
after S3 resume.

Now I have a strange S3 resume (2.6.11.11 kernel) problem with sata
device on my thinkpad.  If i resume within 1 minute after I suspend
everything works fine. But, if I resume after a couple of minutes, I
get the following error

ATA: abnormal status 0x80 on port 0x1F7
ATA: abnormal status 0x80 on port 0x1F7
ATA: abnormal status 0x80 on port 0x1F7

Nothing works after this..I have to manually powercycle the laptop.


Thx
tpr
