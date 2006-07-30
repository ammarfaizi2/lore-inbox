Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbWG3NIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWG3NIe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 09:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbWG3NIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 09:08:34 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:63928 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750798AbWG3NId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 09:08:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=AR+tEv2OygNqwxbKww3o1tkchCtpKHSkslFD4IpXL++Rui4Cdh8Ah/wxLQuklosEfY5HshAfRtetrGRBc1EtbL2zlq5SVzCTYhM5qd4yBieUvCPXjn/POEbqYACGbbYrDO8maTIzMVGXk90put/Vcg21xAX62cDrwR+/t/8Ga0Y=
Message-ID: <9a8748490607300608v65ce3bdcsbb47273bb82a2d6c@mail.gmail.com>
Date: Sun, 30 Jul 2006 15:08:32 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: 2.6.18-rc3 - ReiserFS - warning: vs-8115: get_num_ver: not directory or indirect item
Cc: "Hans Reiser" <reiser@namesys.com>,
       "ReiserFS List" <reiserfs-list@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just got a warning message with 2.6.18-rc3 that I've never seen before :

  ReiserFS: sda4: warning: vs-8115: get_num_ver: not directory or indirect item

The message showed up twice in dmesg during two parallel "make -j3"
builds of the 2.6.18-rc3 kernel source in two sepperate directories.
I've tried to reproduce it but without luck.

It would be nice if someone could tell me what the message means and
wether or not I should be worried about it.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
