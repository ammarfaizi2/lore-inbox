Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbVLNDqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbVLNDqp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 22:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932603AbVLNDqp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 22:46:45 -0500
Received: from xproxy.gmail.com ([66.249.82.192]:9264 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932098AbVLNDqo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 22:46:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=J6KbHP4CpAiHgb+W67DRFix8Xc8bqMHVqsSpg6Z9YWVZVYUeZigMahzQyFULhp4e536dCYlKkgk94KS2D+sgJyhY5TEh+jZuBYN2x2chR0dit0QAQrEs8QnyL+MB/bjUdhgRxUmo9nlri3jDqArr67LGj9akp24mxAWj/gJK70o=
From: Kurt Wall <kwallinator@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Console Goes Blank When Booting 2.6.15-rc5
Date: Tue, 13 Dec 2005 22:47:54 -0500
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512132247.54341.kwallinator@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As Jesper Juhl has reported, if I boot 2.6.15-rc5 with vga=normal,
everything is fine. If I boot using my preferred size (vga=794),
the console goes blank. Because I'm a touch typist, I can login and
start X and everything is copacetic, but as soon as I leave X, I'm
back to the blank screen. From X, if I flip over to a VC, the VC
display is garbled and has artifacts from the X display.

This worked fine with 2.6.14.3, and I didn't change the console, 
framebuffer, or vesa options between the two kernels. Not sure how 
to proceed, but I sure would like my high res console screens back.

Thanks,

Kurt
-- 
"What's another word for Thesaurus?"
  -- Steven Wright
