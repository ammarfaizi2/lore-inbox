Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311322AbSCZMif>; Tue, 26 Mar 2002 07:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311434AbSCZMi0>; Tue, 26 Mar 2002 07:38:26 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40459 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S311322AbSCZMiU>;
	Tue, 26 Mar 2002 07:38:20 -0500
Message-ID: <3CA06B66.7070701@mandrakesoft.com>
Date: Tue, 26 Mar 2002 07:36:54 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: aj@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Problems with Tigon v0.97
In-Reply-To: <ho1ye7tyqx.fsf@gee.suse.de> <20020326.024210.55219079.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:

>It's an amd756 chipset bug.  bcm5700 chooses to work around it in
>their driver, when it really belongs as a generic PCI fixup in
>the kernel.
>

bcm5700 works around AMD762 bug -- and that workaround should be in 
stock 2.4.18 and 2.5.7 kernels now as a PCI quirk.  I think something 
else is going on here...

    Jeff





