Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263624AbTJWPoU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 11:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263627AbTJWPoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 11:44:20 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:61641 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S263624AbTJWPoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 11:44:14 -0400
Date: Thu, 23 Oct 2003 13:44:25 -0300
From: Flavio Bruno Leitner <fbl@conectiva.com.br>
To: linux-kernel@vger.kernel.org
Subject: kernel/initrd and rootfs over LVM 
Message-ID: <20031023164425.GC21031@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm using kernel 2.6.0-test7 and as far I understand 
prepare_namespace() checks if saved_root_name[0] is
not null (I'm passing root=/dev/vg0/lvroot), then
name_to_dev_t() try to guess what MINOR and MAJOR 
are used by the root device. 

Well, I can be missing something but name_to_dev_t()
does not handle lvm devices, right? 

Regards,

-- 
Flávio Bruno Leitner <fbl@conectiva.com.br>
[ E74B 0BD0 5E05 C385 239E  531C BC17 D670 7FF0 A9E0 ]
