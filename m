Return-Path: <linux-kernel-owner+w=401wt.eu-S1754062AbWL1NI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754062AbWL1NI2 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 08:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754837AbWL1NI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 08:08:28 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:29037 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754062AbWL1NI1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 08:08:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=G5v/UYKt6xPXLuf220Elk2ogKuBQMM5eaE07C3luuUWBsiutZoENI9gwG0zeakS9pSwyxNOP+5dU8N70EAOTqA4uK4NLQOptr0hYO88WEIM1vXqUmfTRagBgvRaAkYa7LdbqTvuaq0835captdmfytLWl2FMOX2VZumP4LJ/Qtk=
Message-ID: <b6a2187b0612280508t24e0a740nd1aabdfeb706fbec@mail.gmail.com>
Date: Thu, 28 Dec 2006 21:08:25 +0800
From: "Jeff Chua" <jeff.chua.linux@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: open /dev/kvm: No such file or directory
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On linux-26..20-rc2, "modprobe kvm-intel" loaded the module
successful, but running qemu returns a error ...

/usr/local/kvm/bin/qemu -hda vdisk.img -cdrom cd.iso -boot d -m 128
open /dev/kvm: No such file or directory
Could not initialize KVM, will disable KVM support

/dev/kvm does not exist.... should I create this before running qemu?
If so, what's the parameters to "mknod"?


Thanks,
Jeff.
