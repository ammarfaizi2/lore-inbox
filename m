Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129958AbQJ0QzM>; Fri, 27 Oct 2000 12:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129998AbQJ0QzC>; Fri, 27 Oct 2000 12:55:02 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:26886 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129958AbQJ0Qyt>; Fri, 27 Oct 2000 12:54:49 -0400
Date: Fri, 27 Oct 2000 10:51:09 -0600
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Jonathan Hudson <jonathan@daria.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pcmcia in test10pre6
Message-ID: <20001027105109.B5628@vger.timpanogas.org>
In-Reply-To: <648.39f967c2.1f52d@trespassersw.daria.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <648.39f967c2.1f52d@trespassersw.daria.co.uk>; from jonathan@daria.co.uk on Fri, Oct 27, 2000 at 11:32:18AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2000 at 11:32:18AM +0000, Jonathan Hudson wrote:
> 
> Previously working in test10pre*, now gives many unresolved symbols:
> 
> 
> /lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol cb_free
> /lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol cb_disable
> /lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol pcmcia_read_memory
> /lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol cb_config
> /lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol pcmcia_close_memory
> /lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol pcmcia_register_mtd
> /lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol read_tuple
> /lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol pcmcia_check_erase_queue
> /lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol cb_release_cis_mem
> /lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol find_io_region
> /lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol write_cis_mem
> /lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol pcmcia_write_memory
> /lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol undo_irq
> /lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol pcmcia_request_irq
> /lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol pcmcia_parse_tuple
> /lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol cb_release
> /lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol release_resource_db
> /lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol cb_alloc
> /lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol pcmcia_get_first_region/lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol release_cis_mem
> /lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol try_irq
> /lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol pcmcia_adjust_resource_info
> /lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol pcmcia_get_next_region
> /lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol cb_enable
> /lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol pcmcia_copy_memory
> /lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol pcmcia_get_tuple_data
> /lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol verify_cis_cache
> /lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol pcmcia_deregister_erase_queue
> /lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol pcmcia_register_erase_queue
> /lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol pcmcia_get_first_tuple
> /lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol MTDHelperEntry
> /lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol read_cis_mem
> /lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol pcmcia_get_next_tuple
> /lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol pcmcia_replace_cis
> /lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol pcmcia_open_memory
> /lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol pcmcia_validate_cis
> /lib/modules/2.4.0-test10/pcmcia/cs.o: unresolved symbol find_mem_region

Grab the pcmcia off sourceforge.  It seems to build and work.  The stuff 
in 2.4 at present is still somewhat broken.  I worked on this until 2:00
last night getting it to build with 2.4.  Thanks to Alan for pointing
me to a package that actually works and will build on 2.4.  

:-)

Jeff

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
