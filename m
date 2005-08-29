Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750994AbVH2ARg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbVH2ARg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 20:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbVH2ARg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 20:17:36 -0400
Received: from havoc.gtf.org ([69.61.125.42]:16541 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1750972AbVH2ARd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 20:17:33 -0400
Date: Sun, 28 Aug 2005 20:17:30 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] change libata license from OSL+GPL to GPL
Message-ID: <20050829001730.GA21619@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch does the following:

- changes license of all code from OSL+GPL to plain ole GPL
  - except for NVIDIA, who hasn't yet responded about sata_nv
  - copyright holders were already contacted privately

- adds info in each driver about where hardware/protocol docs may be
  obtained

- where I have made major contributions, updated copyright dates


diff --git a/drivers/scsi/ahci.c b/drivers/scsi/ahci.c
--- a/drivers/scsi/ahci.c
+++ b/drivers/scsi/ahci.c
@@ -1,26 +1,34 @@
 /*
  *  ahci.c - AHCI SATA support
  *
- *  Copyright 2004 Red Hat, Inc.
+ *  Maintained by:  Jeff Garzik <jgarzik@pobox.com>
+ *    		    Please ALWAYS copy linux-ide@vger.kernel.org
+ *		    on emails.
  *
- *  The contents of this file are subject to the Open
- *  Software License version 1.1 that can be found at
- *  http://www.opensource.org/licenses/osl-1.1.txt and is included herein
- *  by reference.
+ *  Copyright 2004-2005 Red Hat, Inc.
  *
- *  Alternatively, the contents of this file may be used under the terms
- *  of the GNU General Public License version 2 (the "GPL") as distributed
- *  in the kernel source COPYING file, in which case the provisions of
- *  the GPL are applicable instead of the above.  If you wish to allow
- *  the use of your version of this file only under the terms of the
- *  GPL and not to allow others to use your version of this file under
- *  the OSL, indicate your decision by deleting the provisions above and
- *  replace them with the notice and other provisions required by the GPL.
- *  If you do not delete the provisions above, a recipient may use your
- *  version of this file under either the OSL or the GPL.
  *
- * Version 1.0 of the AHCI specification:
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2, or (at your option)
+ *  any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; see the file COPYING.  If not, write to
+ *  the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *
+ * libata documentation is available via 'make {ps|pdf}docs',
+ * as Documentation/DocBook/libata.*
+ *
+ * AHCI hardware documentation:
  * http://www.intel.com/technology/serialata/pdf/rev1_0.pdf
+ * http://www.intel.com/technology/serialata/pdf/rev1_1.pdf
  *
  */
 
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -1,24 +1,42 @@
 /*
-
-    ata_piix.c - Intel PATA/SATA controllers
-
-    Maintained by:  Jeff Garzik <jgarzik@pobox.com>
-    		    Please ALWAYS copy linux-ide@vger.kernel.org
-		    on emails.
-
-
-	Copyright 2003-2004 Red Hat Inc
-	Copyright 2003-2004 Jeff Garzik
-
-
-	Copyright header from piix.c:
-
-    Copyright (C) 1998-1999 Andrzej Krzysztofowicz, Author and Maintainer
-    Copyright (C) 1998-2000 Andre Hedrick <andre@linux-ide.org>
-    Copyright (C) 2003 Red Hat Inc <alan@redhat.com>
-
-    May be copied or modified under the terms of the GNU General Public License
-
+ *    ata_piix.c - Intel PATA/SATA controllers
+ *
+ *    Maintained by:  Jeff Garzik <jgarzik@pobox.com>
+ *    		    Please ALWAYS copy linux-ide@vger.kernel.org
+ *		    on emails.
+ *
+ *
+ *	Copyright 2003-2005 Red Hat Inc
+ *	Copyright 2003-2005 Jeff Garzik
+ *
+ *
+ *	Copyright header from piix.c:
+ *
+ *  Copyright (C) 1998-1999 Andrzej Krzysztofowicz, Author and Maintainer
+ *  Copyright (C) 1998-2000 Andre Hedrick <andre@linux-ide.org>
+ *  Copyright (C) 2003 Red Hat Inc <alan@redhat.com>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2, or (at your option)
+ *  any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; see the file COPYING.  If not, write to
+ *  the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *
+ *  libata documentation is available via 'make {ps|pdf}docs',
+ *  as Documentation/DocBook/libata.*
+ *
+ *  Hardware documentation available at http://developer.intel.com/
+ *
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1,25 +1,35 @@
 /*
-   libata-core.c - helper library for ATA
-
-   Copyright 2003-2004 Red Hat, Inc.  All rights reserved.
-   Copyright 2003-2004 Jeff Garzik
-
-   The contents of this file are subject to the Open
-   Software License version 1.1 that can be found at
-   http://www.opensource.org/licenses/osl-1.1.txt and is included herein
-   by reference.
-
-   Alternatively, the contents of this file may be used under the terms
-   of the GNU General Public License version 2 (the "GPL") as distributed
-   in the kernel source COPYING file, in which case the provisions of
-   the GPL are applicable instead of the above.  If you wish to allow
-   the use of your version of this file only under the terms of the
-   GPL and not to allow others to use your version of this file under
-   the OSL, indicate your decision by deleting the provisions above and
-   replace them with the notice and other provisions required by the GPL.
-   If you do not delete the provisions above, a recipient may use your
-   version of this file under either the OSL or the GPL.
-
+ *  libata-core.c - helper library for ATA
+ *
+ *  Maintained by:  Jeff Garzik <jgarzik@pobox.com>
+ *    		    Please ALWAYS copy linux-ide@vger.kernel.org
+ *		    on emails.
+ *
+ *  Copyright 2003-2004 Red Hat, Inc.  All rights reserved.
+ *  Copyright 2003-2004 Jeff Garzik
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2, or (at your option)
+ *  any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; see the file COPYING.  If not, write to
+ *  the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *
+ *  libata documentation is available via 'make {ps|pdf}docs',
+ *  as Documentation/DocBook/libata.*
+ *
+ *  Hardware documentation available from http://www.t13.org/ and
+ *  http://www.sata-io.org/
+ *
  */
 
 #include <linux/config.h>
diff --git a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c
+++ b/drivers/scsi/libata-scsi.c
@@ -1,25 +1,36 @@
 /*
-   libata-scsi.c - helper library for ATA
-
-   Copyright 2003-2004 Red Hat, Inc.  All rights reserved.
-   Copyright 2003-2004 Jeff Garzik
-
-   The contents of this file are subject to the Open
-   Software License version 1.1 that can be found at
-   http://www.opensource.org/licenses/osl-1.1.txt and is included herein
-   by reference.
-
-   Alternatively, the contents of this file may be used under the terms
-   of the GNU General Public License version 2 (the "GPL") as distributed
-   in the kernel source COPYING file, in which case the provisions of
-   the GPL are applicable instead of the above.  If you wish to allow
-   the use of your version of this file only under the terms of the
-   GPL and not to allow others to use your version of this file under
-   the OSL, indicate your decision by deleting the provisions above and
-   replace them with the notice and other provisions required by the GPL.
-   If you do not delete the provisions above, a recipient may use your
-   version of this file under either the OSL or the GPL.
-
+ *  libata-scsi.c - helper library for ATA
+ *
+ *  Maintained by:  Jeff Garzik <jgarzik@pobox.com>
+ *    		    Please ALWAYS copy linux-ide@vger.kernel.org
+ *		    on emails.
+ *
+ *  Copyright 2003-2004 Red Hat, Inc.  All rights reserved.
+ *  Copyright 2003-2004 Jeff Garzik
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2, or (at your option)
+ *  any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; see the file COPYING.  If not, write to
+ *  the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *
+ *  libata documentation is available via 'make {ps|pdf}docs',
+ *  as Documentation/DocBook/libata.*
+ *
+ *  Hardware documentation available from
+ *  - http://www.t10.org/
+ *  - http://www.t13.org/
+ *
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/scsi/libata.h b/drivers/scsi/libata.h
--- a/drivers/scsi/libata.h
+++ b/drivers/scsi/libata.h
@@ -1,25 +1,28 @@
 /*
-   libata.h - helper library for ATA
-
-   Copyright 2003-2004 Red Hat, Inc.  All rights reserved.
-   Copyright 2003-2004 Jeff Garzik
-
-   The contents of this file are subject to the Open
-   Software License version 1.1 that can be found at
-   http://www.opensource.org/licenses/osl-1.1.txt and is included herein
-   by reference.
-
-   Alternatively, the contents of this file may be used under the terms
-   of the GNU General Public License version 2 (the "GPL") as distributed
-   in the kernel source COPYING file, in which case the provisions of
-   the GPL are applicable instead of the above.  If you wish to allow
-   the use of your version of this file only under the terms of the
-   GPL and not to allow others to use your version of this file under
-   the OSL, indicate your decision by deleting the provisions above and
-   replace them with the notice and other provisions required by the GPL.
-   If you do not delete the provisions above, a recipient may use your
-   version of this file under either the OSL or the GPL.
-
+ *  libata.h - helper library for ATA
+ *
+ *  Copyright 2003-2004 Red Hat, Inc.  All rights reserved.
+ *  Copyright 2003-2004 Jeff Garzik
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2, or (at your option)
+ *  any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; see the file COPYING.  If not, write to
+ *  the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *
+ *  libata documentation is available via 'make {ps|pdf}docs',
+ *  as Documentation/DocBook/libata.*
+ *
  */
 
 #ifndef __LIBATA_H__
diff --git a/drivers/scsi/sata_nv.c b/drivers/scsi/sata_nv.c
--- a/drivers/scsi/sata_nv.c
+++ b/drivers/scsi/sata_nv.c
@@ -20,6 +20,17 @@
  *  If you do not delete the provisions above, a recipient may use your
  *  version of this file under either the OSL or the GPL.
  *
+ *
+ *  libata documentation is available via 'make {ps|pdf}docs',
+ *  as Documentation/DocBook/libata.*
+ *
+ *  No hardware documentation available outside of NVIDIA.
+ *  This driver programs the NVIDIA SATA controller in a similar
+ *  fashion as with other PCI IDE BMDMA controllers, with a few
+ *  NV-specific details such as register offsets, SATA phy location,
+ *  hotplug info, etc.
+ *
+ *
  *  0.06
  *     - Added generic SATA support by using a pci_device_id that filters on
  *       the IDE storage class code.
diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
--- a/drivers/scsi/sata_promise.c
+++ b/drivers/scsi/sata_promise.c
@@ -7,21 +7,26 @@
  *
  *  Copyright 2003-2004 Red Hat, Inc.
  *
- *  The contents of this file are subject to the Open
- *  Software License version 1.1 that can be found at
- *  http://www.opensource.org/licenses/osl-1.1.txt and is included herein
- *  by reference.
  *
- *  Alternatively, the contents of this file may be used under the terms
- *  of the GNU General Public License version 2 (the "GPL") as distributed
- *  in the kernel source COPYING file, in which case the provisions of
- *  the GPL are applicable instead of the above.  If you wish to allow
- *  the use of your version of this file only under the terms of the
- *  GPL and not to allow others to use your version of this file under
- *  the OSL, indicate your decision by deleting the provisions above and
- *  replace them with the notice and other provisions required by the GPL.
- *  If you do not delete the provisions above, a recipient may use your
- *  version of this file under either the OSL or the GPL.
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2, or (at your option)
+ *  any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; see the file COPYING.  If not, write to
+ *  the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *
+ *  libata documentation is available via 'make {ps|pdf}docs',
+ *  as Documentation/DocBook/libata.*
+ *
+ *  Hardware information only available under NDA.
  *
  */
 
diff --git a/drivers/scsi/sata_promise.h b/drivers/scsi/sata_promise.h
--- a/drivers/scsi/sata_promise.h
+++ b/drivers/scsi/sata_promise.h
@@ -3,21 +3,24 @@
  *
  *  Copyright 2003-2004 Red Hat, Inc.
  *
- *  The contents of this file are subject to the Open
- *  Software License version 1.1 that can be found at
- *  http://www.opensource.org/licenses/osl-1.1.txt and is included herein
- *  by reference.
- *
- *  Alternatively, the contents of this file may be used under the terms
- *  of the GNU General Public License version 2 (the "GPL") as distributed
- *  in the kernel source COPYING file, in which case the provisions of
- *  the GPL are applicable instead of the above.  If you wish to allow
- *  the use of your version of this file only under the terms of the
- *  GPL and not to allow others to use your version of this file under
- *  the OSL, indicate your decision by deleting the provisions above and
- *  replace them with the notice and other provisions required by the GPL.
- *  If you do not delete the provisions above, a recipient may use your
- *  version of this file under either the OSL or the GPL.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2, or (at your option)
+ *  any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; see the file COPYING.  If not, write to
+ *  the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *
+ *  libata documentation is available via 'make {ps|pdf}docs',
+ *  as Documentation/DocBook/libata.*
  *
  */
 
diff --git a/drivers/scsi/sata_qstor.c b/drivers/scsi/sata_qstor.c
--- a/drivers/scsi/sata_qstor.c
+++ b/drivers/scsi/sata_qstor.c
@@ -6,21 +6,24 @@
  *  Copyright 2005 Pacific Digital Corporation.
  *  (OSL/GPL code release authorized by Jalil Fadavi).
  *
- *  The contents of this file are subject to the Open
- *  Software License version 1.1 that can be found at
- *  http://www.opensource.org/licenses/osl-1.1.txt and is included herein
- *  by reference.
  *
- *  Alternatively, the contents of this file may be used under the terms
- *  of the GNU General Public License version 2 (the "GPL") as distributed
- *  in the kernel source COPYING file, in which case the provisions of
- *  the GPL are applicable instead of the above.  If you wish to allow
- *  the use of your version of this file only under the terms of the
- *  GPL and not to allow others to use your version of this file under
- *  the OSL, indicate your decision by deleting the provisions above and
- *  replace them with the notice and other provisions required by the GPL.
- *  If you do not delete the provisions above, a recipient may use your
- *  version of this file under either the OSL or the GPL.
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2, or (at your option)
+ *  any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; see the file COPYING.  If not, write to
+ *  the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *
+ *  libata documentation is available via 'make {ps|pdf}docs',
+ *  as Documentation/DocBook/libata.*
  *
  */
 
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -5,24 +5,27 @@
  *  		    Please ALWAYS copy linux-ide@vger.kernel.org
  *		    on emails.
  *
- *  Copyright 2003 Red Hat, Inc.
+ *  Copyright 2003-2005 Red Hat, Inc.
  *  Copyright 2003 Benjamin Herrenschmidt
  *
- *  The contents of this file are subject to the Open
- *  Software License version 1.1 that can be found at
- *  http://www.opensource.org/licenses/osl-1.1.txt and is included herein
- *  by reference.
- *
- *  Alternatively, the contents of this file may be used under the terms
- *  of the GNU General Public License version 2 (the "GPL") as distributed
- *  in the kernel source COPYING file, in which case the provisions of
- *  the GPL are applicable instead of the above.  If you wish to allow
- *  the use of your version of this file only under the terms of the
- *  GPL and not to allow others to use your version of this file under
- *  the OSL, indicate your decision by deleting the provisions above and
- *  replace them with the notice and other provisions required by the GPL.
- *  If you do not delete the provisions above, a recipient may use your
- *  version of this file under either the OSL or the GPL.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2, or (at your option)
+ *  any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; see the file COPYING.  If not, write to
+ *  the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *
+ *  libata documentation is available via 'make {ps|pdf}docs',
+ *  as Documentation/DocBook/libata.*
  *
  */
 
diff --git a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
--- a/drivers/scsi/sata_sis.c
+++ b/drivers/scsi/sata_sis.c
@@ -7,21 +7,26 @@
  *
  *  Copyright 2004 Uwe Koziolek
  *
- *  The contents of this file are subject to the Open
- *  Software License version 1.1 that can be found at
- *  http://www.opensource.org/licenses/osl-1.1.txt and is included herein
- *  by reference.
  *
- *  Alternatively, the contents of this file may be used under the terms
- *  of the GNU General Public License version 2 (the "GPL") as distributed
- *  in the kernel source COPYING file, in which case the provisions of
- *  the GPL are applicable instead of the above.  If you wish to allow
- *  the use of your version of this file only under the terms of the
- *  GPL and not to allow others to use your version of this file under
- *  the OSL, indicate your decision by deleting the provisions above and
- *  replace them with the notice and other provisions required by the GPL.
- *  If you do not delete the provisions above, a recipient may use your
- *  version of this file under either the OSL or the GPL.
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2, or (at your option)
+ *  any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; see the file COPYING.  If not, write to
+ *  the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *
+ *  libata documentation is available via 'make {ps|pdf}docs',
+ *  as Documentation/DocBook/libata.*
+ *
+ *  Hardware documentation available under NDA.
  *
  */
 
diff --git a/drivers/scsi/sata_svw.c b/drivers/scsi/sata_svw.c
--- a/drivers/scsi/sata_svw.c
+++ b/drivers/scsi/sata_svw.c
@@ -13,21 +13,26 @@
  *  This driver probably works with non-Apple versions of the
  *  Broadcom chipset...
  *
- *  The contents of this file are subject to the Open
- *  Software License version 1.1 that can be found at
- *  http://www.opensource.org/licenses/osl-1.1.txt and is included herein
- *  by reference.
  *
- *  Alternatively, the contents of this file may be used under the terms
- *  of the GNU General Public License version 2 (the "GPL") as distributed
- *  in the kernel source COPYING file, in which case the provisions of
- *  the GPL are applicable instead of the above.  If you wish to allow
- *  the use of your version of this file only under the terms of the
- *  GPL and not to allow others to use your version of this file under
- *  the OSL, indicate your decision by deleting the provisions above and
- *  replace them with the notice and other provisions required by the GPL.
- *  If you do not delete the provisions above, a recipient may use your
- *  version of this file under either the OSL or the GPL.
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2, or (at your option)
+ *  any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; see the file COPYING.  If not, write to
+ *  the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *
+ *  libata documentation is available via 'make {ps|pdf}docs',
+ *  as Documentation/DocBook/libata.*
+ *
+ *  Hardware documentation available under NDA.
  *
  */
 
diff --git a/drivers/scsi/sata_sx4.c b/drivers/scsi/sata_sx4.c
--- a/drivers/scsi/sata_sx4.c
+++ b/drivers/scsi/sata_sx4.c
@@ -7,21 +7,26 @@
  *
  *  Copyright 2003-2004 Red Hat, Inc.
  *
- *  The contents of this file are subject to the Open
- *  Software License version 1.1 that can be found at
- *  http://www.opensource.org/licenses/osl-1.1.txt and is included herein
- *  by reference.
  *
- *  Alternatively, the contents of this file may be used under the terms
- *  of the GNU General Public License version 2 (the "GPL") as distributed
- *  in the kernel source COPYING file, in which case the provisions of
- *  the GPL are applicable instead of the above.  If you wish to allow
- *  the use of your version of this file only under the terms of the
- *  GPL and not to allow others to use your version of this file under
- *  the OSL, indicate your decision by deleting the provisions above and
- *  replace them with the notice and other provisions required by the GPL.
- *  If you do not delete the provisions above, a recipient may use your
- *  version of this file under either the OSL or the GPL.
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2, or (at your option)
+ *  any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; see the file COPYING.  If not, write to
+ *  the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *
+ *  libata documentation is available via 'make {ps|pdf}docs',
+ *  as Documentation/DocBook/libata.*
+ *
+ *  Hardware documentation available under NDA.
  *
  */
 
diff --git a/drivers/scsi/sata_uli.c b/drivers/scsi/sata_uli.c
--- a/drivers/scsi/sata_uli.c
+++ b/drivers/scsi/sata_uli.c
@@ -1,21 +1,26 @@
 /*
  *  sata_uli.c - ULi Electronics SATA
  *
- *  The contents of this file are subject to the Open
- *  Software License version 1.1 that can be found at
- *  http://www.opensource.org/licenses/osl-1.1.txt and is included herein
- *  by reference.
  *
- *  Alternatively, the contents of this file may be used under the terms
- *  of the GNU General Public License version 2 (the "GPL") as distributed
- *  in the kernel source COPYING file, in which case the provisions of
- *  the GPL are applicable instead of the above.  If you wish to allow
- *  the use of your version of this file only under the terms of the
- *  GPL and not to allow others to use your version of this file under
- *  the OSL, indicate your decision by deleting the provisions above and
- *  replace them with the notice and other provisions required by the GPL.
- *  If you do not delete the provisions above, a recipient may use your
- *  version of this file under either the OSL or the GPL.
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2, or (at your option)
+ *  any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; see the file COPYING.  If not, write to
+ *  the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *
+ *  libata documentation is available via 'make {ps|pdf}docs',
+ *  as Documentation/DocBook/libata.*
+ *
+ *  Hardware documentation available under NDA.
  *
  */
 
diff --git a/drivers/scsi/sata_via.c b/drivers/scsi/sata_via.c
--- a/drivers/scsi/sata_via.c
+++ b/drivers/scsi/sata_via.c
@@ -1,34 +1,38 @@
 /*
-   sata_via.c - VIA Serial ATA controllers
-
-   Maintained by:  Jeff Garzik <jgarzik@pobox.com>
-   		   Please ALWAYS copy linux-ide@vger.kernel.org
+ *  sata_via.c - VIA Serial ATA controllers
+ *
+ *  Maintained by:  Jeff Garzik <jgarzik@pobox.com>
+ * 		   Please ALWAYS copy linux-ide@vger.kernel.org
  		   on emails.
-
-   Copyright 2003-2004 Red Hat, Inc.  All rights reserved.
-   Copyright 2003-2004 Jeff Garzik
-
-   The contents of this file are subject to the Open
-   Software License version 1.1 that can be found at
-   http://www.opensource.org/licenses/osl-1.1.txt and is included herein
-   by reference.
-
-   Alternatively, the contents of this file may be used under the terms
-   of the GNU General Public License version 2 (the "GPL") as distributed
-   in the kernel source COPYING file, in which case the provisions of
-   the GPL are applicable instead of the above.  If you wish to allow
-   the use of your version of this file only under the terms of the
-   GPL and not to allow others to use your version of this file under
-   the OSL, indicate your decision by deleting the provisions above and
-   replace them with the notice and other provisions required by the GPL.
-   If you do not delete the provisions above, a recipient may use your
-   version of this file under either the OSL or the GPL.
-
-   ----------------------------------------------------------------------
-
-   To-do list:
-   * VT6421 PATA support
-
+ *
+ *  Copyright 2003-2004 Red Hat, Inc.  All rights reserved.
+ *  Copyright 2003-2004 Jeff Garzik
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2, or (at your option)
+ *  any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; see the file COPYING.  If not, write to
+ *  the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *
+ *  libata documentation is available via 'make {ps|pdf}docs',
+ *  as Documentation/DocBook/libata.*
+ *
+ *  Hardware documentation available under NDA.
+ *
+ *
+ *  To-do list:
+ *  - VT6421 PATA support
+ *
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/scsi/sata_vsc.c b/drivers/scsi/sata_vsc.c
--- a/drivers/scsi/sata_vsc.c
+++ b/drivers/scsi/sata_vsc.c
@@ -9,9 +9,29 @@
  *
  *  Bits from Jeff Garzik, Copyright RedHat, Inc.
  *
- *  This file is subject to the terms and conditions of the GNU General Public
- *  License.  See the file "COPYING" in the main directory of this archive
- *  for more details.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2, or (at your option)
+ *  any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; see the file COPYING.  If not, write to
+ *  the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *
+ *  libata documentation is available via 'make {ps|pdf}docs',
+ *  as Documentation/DocBook/libata.*
+ *
+ *  Vitesse hardware documentation presumably available under NDA.
+ *  Intel 31244 (same hardware interface) documentation presumably
+ *  available from http://developer.intel.com/
+ *
  */
 
 #include <linux/kernel.h>
diff --git a/include/linux/ata.h b/include/linux/ata.h
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -1,24 +1,29 @@
 
 /*
-   Copyright 2003-2004 Red Hat, Inc.  All rights reserved.
-   Copyright 2003-2004 Jeff Garzik
-
-   The contents of this file are subject to the Open
-   Software License version 1.1 that can be found at
-   http://www.opensource.org/licenses/osl-1.1.txt and is included herein
-   by reference.
-
-   Alternatively, the contents of this file may be used under the terms
-   of the GNU General Public License version 2 (the "GPL") as distributed
-   in the kernel source COPYING file, in which case the provisions of
-   the GPL are applicable instead of the above.  If you wish to allow
-   the use of your version of this file only under the terms of the
-   GPL and not to allow others to use your version of this file under
-   the OSL, indicate your decision by deleting the provisions above and
-   replace them with the notice and other provisions required by the GPL.
-   If you do not delete the provisions above, a recipient may use your
-   version of this file under either the OSL or the GPL.
-
+ *  Copyright 2003-2004 Red Hat, Inc.  All rights reserved.
+ *  Copyright 2003-2004 Jeff Garzik
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2, or (at your option)
+ *  any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; see the file COPYING.  If not, write to
+ *  the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *
+ *  libata documentation is available via 'make {ps|pdf}docs',
+ *  as Documentation/DocBook/libata.*
+ *
+ *  Hardware documentation available from http://www.t13.org/
+ *
  */
 
 #ifndef __LINUX_ATA_H__
diff --git a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1,23 +1,26 @@
 /*
-   Copyright 2003-2004 Red Hat, Inc.  All rights reserved.
-   Copyright 2003-2004 Jeff Garzik
-
-   The contents of this file are subject to the Open
-   Software License version 1.1 that can be found at
-   http://www.opensource.org/licenses/osl-1.1.txt and is included herein
-   by reference.
-
-   Alternatively, the contents of this file may be used under the terms
-   of the GNU General Public License version 2 (the "GPL") as distributed
-   in the kernel source COPYING file, in which case the provisions of
-   the GPL are applicable instead of the above.  If you wish to allow
-   the use of your version of this file only under the terms of the
-   GPL and not to allow others to use your version of this file under
-   the OSL, indicate your decision by deleting the provisions above and
-   replace them with the notice and other provisions required by the GPL.
-   If you do not delete the provisions above, a recipient may use your
-   version of this file under either the OSL or the GPL.
-
+ *  Copyright 2003-2005 Red Hat, Inc.  All rights reserved.
+ *  Copyright 2003-2005 Jeff Garzik
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2, or (at your option)
+ *  any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; see the file COPYING.  If not, write to
+ *  the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *
+ *  libata documentation is available via 'make {ps|pdf}docs',
+ *  as Documentation/DocBook/libata.*
+ *
  */
 
 #ifndef __LINUX_LIBATA_H__
