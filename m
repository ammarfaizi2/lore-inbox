Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129071AbQJ0O1Y>; Fri, 27 Oct 2000 10:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129209AbQJ0O1O>; Fri, 27 Oct 2000 10:27:14 -0400
Received: from proxy.jakinternet.co.uk ([212.41.43.4]:17171 "HELO
	proxy.jakinternet.co.uk") by vger.kernel.org with SMTP
	id <S129071AbQJ0O1I>; Fri, 27 Oct 2000 10:27:08 -0400
To: linux-kernel@vger.kernel.org
From: Jonathan Hudson <jonathan@daria.co.uk>
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
x-no-productlinks: yes
Subject: pcmcia in test10pre6
X-Newsgroups: fa.linux.kernel
Content-Type: text/plain; charset=iso-8859-1
NNTP-Posting-Host: 192.168.1.1
Message-ID: <648.39f967c2.1f52d@trespassersw.daria.co.uk>
Date: Fri, 27 Oct 2000 11:32:18 GMT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Previously working in test10pre*, now gives many unresolved symbols:


/lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol cb_free
/lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol cb_disable
/lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol pcmcia_read_memory
/lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol cb_config
/lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol pcmcia_close_memory
/lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol pcmcia_register_mtd
/lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol read_tuple
/lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol pcmcia_check_erase_queue
/lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol cb_release_cis_mem
/lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol find_io_region
/lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol write_cis_mem
/lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol pcmcia_write_memory
/lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol undo_irq
/lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol pcmcia_request_irq
/lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol pcmcia_parse_tuple
/lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol cb_release
/lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol release_resource_db
/lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol cb_alloc
/lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol pcmcia_get_first_region/lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol release_cis_mem
/lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol try_irq
/lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol pcmcia_adjust_resource_info
/lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol pcmcia_get_next_region
/lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol cb_enable
/lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol pcmcia_copy_memory
/lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol pcmcia_get_tuple_data
/lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol verify_cis_cache
/lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol pcmcia_deregister_erase_queue
/lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol pcmcia_register_erase_queue
/lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol pcmcia_get_first_tuple
/lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol MTDHelperEntry
/lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol read_cis_mem
/lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol pcmcia_get_next_tuple
/lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol pcmcia_replace_cis
/lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol pcmcia_open_memory
/lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol pcmcia_validate_cis
/lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol find_mem_region
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
