Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbVAaVQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbVAaVQT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 16:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbVAaVQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 16:16:19 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:56770 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261368AbVAaVPz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 16:15:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=n71z0DidDyc0j0O3KTdw+E7v8qE6rWJ+4mwNbdgA+ktBGY/hR3sBL/JfKQ+sab0QdB4NK6VMzObwwxvU7vlhLG8dCj67AxtVxycsiBRjPwTwGMBda3ENNSqhfe4aK66SBsDgwHrDx7oW6sw/huQKn17b5feVK1R78HbpxvFNpwg=
Message-ID: <7f800d9f05013113157978f158@mail.gmail.com>
Date: Mon, 31 Jan 2005 13:15:54 -0800
From: Andre Eisenbach <int2str@gmail.com>
Reply-To: Andre Eisenbach <int2str@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.11-rc2-mm2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050129131134.75dacb41.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050129131134.75dacb41.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

My PCMCIA slot (yenta_socket) doesn't work anymore with 2.6.11-rc2-m2.
See the dmesg output below. It works fine with 2.6.11-rc1-mm1.

Let me know if you need any additional information.

Thanks,
    Andre

--- snipp ---

Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
kobject_register failed for pcmcia_core (-17)
 [<c021686b>] kobject_register+0x5b/0x70
 [<c0130620>] mod_sysfs_setup+0x50/0xb0
 [<c0131999>] load_module+0x959/0xaa0
 [<c0131b6b>] sys_init_module+0x5b/0x1a0
 [<c010300d>] sysenter_past_esp+0x52/0x75
rsrc_nonstatic: Unknown symbol release_cis_mem
rsrc_nonstatic: Unknown symbol pcmcia_socket_list
rsrc_nonstatic: Unknown symbol pccard_validate_cis
rsrc_nonstatic: Unknown symbol destroy_cis_cache
rsrc_nonstatic: Unknown symbol pcmcia_socket_list_rwsem
yenta_socket: Unknown symbol dead_socket
yenta_socket: Unknown symbol pcmcia_register_socket
yenta_socket: Unknown symbol pcmcia_socket_dev_resume
yenta_socket: Unknown symbol pcmcia_parse_events
yenta_socket: Unknown symbol pcmcia_socket_dev_suspend
yenta_socket: Unknown symbol pccard_nonstatic_ops
yenta_socket: Unknown symbol pcmcia_unregister_socket
kobject_register failed for pcmcia_core (-17)
 [<c021686b>] kobject_register+0x5b/0x70
 [<c0130620>] mod_sysfs_setup+0x50/0xb0
 [<c0131999>] load_module+0x959/0xaa0
 [<c0131b6b>] sys_init_module+0x5b/0x1a0
 [<c010300d>] sysenter_past_esp+0x52/0x75
pcmcia: Unknown symbol pcmcia_get_socket
pcmcia: Unknown symbol pcmcia_get_window
pcmcia: Unknown symbol pcmcia_suspend_card
pcmcia: Unknown symbol pcmcia_replace_cis
pcmcia: Unknown symbol pcmcia_socket_list
pcmcia: Unknown symbol pcmcia_get_card_services_info
pcmcia: Unknown symbol pccard_get_configuration_info
pcmcia: Unknown symbol pcmcia_lookup_bus
pcmcia: Unknown symbol pccard_get_first_tuple
pcmcia: Unknown symbol pccard_register_pcmcia
pcmcia: Unknown symbol pccard_read_tuple
pcmcia: Unknown symbol pccard_validate_cis
pcmcia: Unknown symbol pccard_access_configuration_register
pcmcia: Unknown symbol pcmcia_insert_card
pcmcia: Unknown symbol pcmcia_adjust_resource_info
pcmcia: Unknown symbol pcmcia_socket_list_rwsem
pcmcia: Unknown symbol pcmcia_resume_card
pcmcia: Unknown symbol pccard_get_status
pcmcia: Unknown symbol pcmcia_validate_mem
pcmcia: Unknown symbol pcmcia_socket_class
pcmcia: Unknown symbol pccard_get_tuple_data
pcmcia: Unknown symbol pcmcia_put_socket
pcmcia: Unknown symbol pcmcia_eject_card
pcmcia: Unknown symbol pccard_reset_card
pcmcia: Unknown symbol pccard_parse_tuple
pcmcia: Unknown symbol pcmcia_get_socket_by_nr
pcmcia: Unknown symbol pccard_get_next_tuple
pcmcia: Unknown symbol pcmcia_get_mem_page
