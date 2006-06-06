Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbWFFIUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbWFFIUT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 04:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWFFIUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 04:20:19 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:59525 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751164AbWFFIUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 04:20:17 -0400
Message-ID: <44853A05.2030101@jp.fujitsu.com>
Date: Tue, 06 Jun 2006 17:17:09 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: akpm@osdl.org, Rajesh Shah <rajesh.shah@intel.com>,
       Grant Grundler <grundler@parisc-linux.org>,
       "bibo,mao" <bibo.mao@intel.com>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [BUG][PATCH 2.6.17-rc5-mm3] bugfix: PCI legacy I/O port free
 driver
References: <447E91CE.7010705@intel.com> <20060601024611.A32490@unix-os.sc.intel.com> <20060601171559.GA16288@colo.lackof.org> <20060601113625.A4043@unix-os.sc.intel.com> <447FA920.9060509@jp.fujitsu.com> <4484263C.1030508@jp.fujitsu.com> <20060606075812.GB19619@kroah.com>
In-Reply-To: <20060606075812.GB19619@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Mon, Jun 05, 2006 at 09:40:28PM +0900, Kenji Kaneshige wrote:
> 
>>Hi Andrew, Greg,
>>
>>Here is a patche to fix a bug that pci_request_regions() doesn't work
>>when it is called after pci_disable_device(), which was reported at:
>>
>>    http://marc.theaimsgroup.com/?l=linux-kernel&m=114914585213991&w=2
>>
>>This bug is introduced by the following "PCI legacy I/O port free
>>driver" patches currently in 2.6.17-rc5-mm3.
>>
>>    o gregkh-pci-pci-legacy-i-o-port-free-driver-changes-to-generic-pci-code.patch
>>    o gregkh-pci-pci-legacy-i-o-port-free-driver-make-emulex-lpfc-driver-legacy-i-o-port-free.patch
>>    o gregkh-pci-pci-legacy-i-o-port-free-driver-make-intel-e1000-driver-legacy-i-o-port-free.patch
>>    o gregkh-pci-pci-legacy-i-o-port-free-driver-update-documentation-pci_txt.patch
>>
>>This patch is against 2.6.17-rc5-mm3. Please see the header of the
>>patch about details.
>>
>>If reposting the fixed version of PCI legacy I/O port free driver
>>patches against the latest Linus tree are preferred rather than this
>>patch, please let me know.
> 
> 
> I think a new set of patches would be the best, as that way when I apply
> them to Linus's tree, there is no point in the patch history that has a
> problem that people might hit.
> 
> So, care to just resend the above 4 patches with your fix included?  Is
> that easy to do?
> 

Sure.
I've already finished those patches and I'm checking them now. I'll
resend them soon after some tests.

Thanks,
Kenji Kaneshige
 

