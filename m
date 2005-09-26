Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751599AbVIZC1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599AbVIZC1k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 22:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751600AbVIZC1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 22:27:40 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:48812 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751599AbVIZC1k convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 22:27:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=XB2hjGgxqX80K0qespZ0m1p8QW7ZK8gwoVn1qAmCaIwqFKevYFBkmjdYCKyRzqrIaKpEvw0eCTRW+whFvBf7mTQnklyMiV0hrgAhPB+PZuwRpZ2PCyt2gRTCyjnzK/636Jz4aqnkAtEXFhmHmvYsdZyoD9Ph08d4UM+zHYTjsOM=
Message-ID: <9e4733910509251927484a70c7@mail.gmail.com>
Date: Sun, 25 Sep 2005 22:27:37 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: usb-snd-audio breakage
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

usb-snd-audio broke in the last 24hrs in Linus' git tree. modprobe of
the module fails. I  have a PSC805 USB audio device.

modprobe snd-usb-audio
err -> snd_usb_audio: Unknown parameter `'

--
Jon Smirl
jonsmirl@gmail.com
