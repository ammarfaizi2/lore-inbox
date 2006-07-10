Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422646AbWGJPPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422646AbWGJPPc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 11:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422649AbWGJPPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 11:15:32 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:38758 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422646AbWGJPPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 11:15:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=OHvHbpMVC+36wjso6rwy7VuRJZyHKETXA9F/0+H4KTlRFXjgHDoGiZsV98u0ECJBiE2Wp/pUI0gRDWzMwvyH6wg7hl/m/uZt9XLTisXxXYXSMTm2oKpuohpfqh9lSQGIp2/LMbRFRk4jJUQDD/9mQJ89H1D+Xv26O9EnLiHTPCM=
Message-ID: <9e4733910607100810r6e02f69g9a3f6d3d1400b397@mail.gmail.com>
Date: Mon, 10 Jul 2006 11:10:16 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: tty's use of file_list_lock and file_move
Cc: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since you want a new subject can you explain tty's use of file_lock to
me? Is there some non-obvious global coordination happening here or is
it work breaking down the big kernel lock that never got finished?

-- 
Jon Smirl
jonsmirl@gmail.com
