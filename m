Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129718AbRALKek>; Fri, 12 Jan 2001 05:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130599AbRALKea>; Fri, 12 Jan 2001 05:34:30 -0500
Received: from m7.limsi.fr ([192.44.78.7]:32772 "EHLO m7.limsi.fr")
	by vger.kernel.org with ESMTP id <S129718AbRALKeU>;
	Fri, 12 Jan 2001 05:34:20 -0500
Message-ID: <3A5EDCDC.70306@limsi.fr>
Date: Fri, 12 Jan 2001 11:30:52 +0100
From: Damien TOURAINE <touraine_english@limsi.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.18 i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Problem with elf and dynamic loading ...
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I'm using dynamic library to load some part of a big software (that use 
several differents modules).
The main program fully use the symboles of the shared object (through 
the dlsym command), however, the functions available in the module are 
not able to use the symbols of the main program.

Is-it a bug of the kernel ?
Is-it to avoid a potential hole of security ?

My system :
Computer : SONY Notebook with a PCMCIA network card and SCSI cardbus.
Kernel : 2.2.18
  I tryied to compile and launch 2.4 -test13, however, I think I didn't 
have the right parameters for the compilation because it don't manage to 
get the bash (still try to compile it) ...
Glibc : 2.2
miscellanous : fully use the elf format, have recompiled the glibc 2.2 
from the GNU tree, have also recompile linux from the kernel.org.

Friendly
  Damien TOURAINE

-- 
--------------------------------------------------------------------
Damien TOURAINE	- +33 1 69 85 81 68
PhD student at LIMSI - CNRS (http://www.limsi.fr)
Bat. 508, Universite Paris-Sud F-91403 Orsay cedex (France)
--------------------------------------------------------------------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
