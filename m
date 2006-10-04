Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161109AbWJDR0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161109AbWJDR0L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 13:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161149AbWJDR0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 13:26:11 -0400
Received: from [69.90.147.196] ([69.90.147.196]:34198 "EHLO mail.kenati.com")
	by vger.kernel.org with ESMTP id S1161109AbWJDR0J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 13:26:09 -0400
Message-ID: <4523F039.80908@kenati.com>
Date: Wed, 04 Oct 2006 10:32:41 -0700
From: Carlos Munoz <carlos@kenati.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problems nfs mounting root filesystem
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

I have a problem when running off a nfs mounted root filesystem. The 
kernel (2.6.18) mounts the root filesystem successfully. However, when 
fstab is accessed I get the following error:

  Can't find / in /etc/fstab

The fstab looks like this:

none            /tmp                    tmpfs   rw              0       0
none            /proc                   proc    defaults        0       0
none            /sys                    sysfs   defaults        0       0


I add the following line to fstab:

192.168.1.8:/tftpboot/carlos/ppc /     nfs     
rw,rsize=8192,wsize=8192,timeo=14,intr              0       0

and now I get the following error:

  mount: Mounting 192.168.1.8:/tftpboot/carlos/ppc on / failed: Protocol 
not supported

Do you know what I'm doing wrong ?

Thanks,


Carlos
