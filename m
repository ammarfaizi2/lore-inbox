Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263192AbTD1KcK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 06:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263199AbTD1KcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 06:32:09 -0400
Received: from pegasus.siol.net ([193.189.160.24]:24000 "EHLO pegasus.siol.net")
	by vger.kernel.org with ESMTP id S263192AbTD1Kbt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 06:31:49 -0400
Subject: error building kernel module for cirrus graphic card - kernel
	2.5.68
From: Andrej Kaligaric <andrej.kaligaric@guest.arnes.si>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-+WaMOAzODiqjwBZCoDEC"
Organization: 
Message-Id: <1051540977.12564.13.camel@Leif.Ericsson>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 28 Apr 2003 16:44:11 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+WaMOAzODiqjwBZCoDEC
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

system: i686/Pentium P4; RHL9.0; custom built 2.4.20-9 kernel;
gcc:3.2.2 (shipped with rhl) 

- configuring the set module for cirrus graphic card (or build it in the
kernel, from this point of view it's the same)
-after building the kernel, try to build the module by 'make modules'.
-I get the error described in the attachment, make exits.

--=-+WaMOAzODiqjwBZCoDEC
Content-Disposition: attachment; filename=errorMakeModules
Content-Type: text/plain; name=errorMakeModules; charset=UTF-8
Content-Transfer-Encoding: 7bit

gcc -Wp,-MD,drivers/video/.cirrusfb.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=pentium4 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    -DKBUILD_BASENAME=cirrusfb -DKBUILD_MODNAME=cirrusfb -c -o drivers/video/.tmp_cirrusfb.o drivers/video/cirrusfb.c
drivers/video/cirrusfb.c:66:25: video/fbcon.h: No such file or directory
drivers/video/cirrusfb.c:67:29: video/fbcon-mfb.h: No such file or directory
drivers/video/cirrusfb.c:68:30: video/fbcon-cfb8.h: No such file or directory
drivers/video/cirrusfb.c:69:31: video/fbcon-cfb16.h: No such file or directory
drivers/video/cirrusfb.c:70:31: video/fbcon-cfb24.h: No such file or directory
drivers/video/cirrusfb.c:71:31: video/fbcon-cfb32.h: No such file or directory
drivers/video/cirrusfb.c:73:21: clgenfb.h: No such file or directory
drivers/video/cirrusfb.c:74:17: vga.h: No such file or directory
drivers/video/cirrusfb.c:370: field `gen' has incomplete type
drivers/video/cirrusfb.c:505: unknown field `fb_get_fix' specified in initializer
drivers/video/cirrusfb.c:505: `fbgen_get_fix' undeclared here (not in a function)
drivers/video/cirrusfb.c:505: initializer element is not constant
drivers/video/cirrusfb.c:505: (near initialization for `clgenfb_ops.fb_read')
drivers/video/cirrusfb.c:506: unknown field `fb_get_var' specified in initializer
drivers/video/cirrusfb.c:506: `fbgen_get_var' undeclared here (not in a function)
drivers/video/cirrusfb.c:506: initializer element is not constant
drivers/video/cirrusfb.c:506: (near initialization for `clgenfb_ops.fb_write')
drivers/video/cirrusfb.c:507: unknown field `fb_set_var' specified in initializer
drivers/video/cirrusfb.c:507: `fbgen_set_var' undeclared here (not in a function)
drivers/video/cirrusfb.c:507: initializer element is not constant
drivers/video/cirrusfb.c:507: (near initialization for `clgenfb_ops.fb_check_var')
drivers/video/cirrusfb.c:508: unknown field `fb_get_cmap' specified in initializer
drivers/video/cirrusfb.c:508: `fbgen_get_cmap' undeclared here (not in a function)
drivers/video/cirrusfb.c:508: initializer element is not constant
drivers/video/cirrusfb.c:508: (near initialization for `clgenfb_ops.fb_set_par')
drivers/video/cirrusfb.c:509: unknown field `fb_set_cmap' specified in initializer
drivers/video/cirrusfb.c:509: `gen_set_cmap' undeclared here (not in a function)
drivers/video/cirrusfb.c:509: initializer element is not constant
drivers/video/cirrusfb.c:509: (near initialization for `clgenfb_ops.fb_setcolreg')
drivers/video/cirrusfb.c:511: `fbgen_pan_display' undeclared here (not in a function)
drivers/video/cirrusfb.c:511: initializer element is not constant
drivers/video/cirrusfb.c:511: (near initialization for `clgenfb_ops.fb_pan_display')
drivers/video/cirrusfb.c:512: `fbgen_blank' undeclared here (not in a function)
drivers/video/cirrusfb.c:512: initializer element is not constant
drivers/video/cirrusfb.c:512: (near initialization for `clgenfb_ops.fb_blank')
drivers/video/cirrusfb.c:536: variable `clgen_hwswitch' has initializer but incomplete type
drivers/video/cirrusfb.c:538: warning: excess elements in struct initializer
drivers/video/cirrusfb.c:538: warning: (near initialization for `clgen_hwswitch')
drivers/video/cirrusfb.c:539: warning: excess elements in struct initializer
drivers/video/cirrusfb.c:539: warning: (near initialization for `clgen_hwswitch')
drivers/video/cirrusfb.c:540: warning: excess elements in struct initializer
drivers/video/cirrusfb.c:540: warning: (near initialization for `clgen_hwswitch')
drivers/video/cirrusfb.c:541: warning: excess elements in struct initializer
drivers/video/cirrusfb.c:541: warning: (near initialization for `clgen_hwswitch')
drivers/video/cirrusfb.c:542: warning: excess elements in struct initializer
drivers/video/cirrusfb.c:542: warning: (near initialization for `clgen_hwswitch')
drivers/video/cirrusfb.c:543: warning: excess elements in struct initializer
drivers/video/cirrusfb.c:543: warning: (near initialization for `clgen_hwswitch')
drivers/video/cirrusfb.c:544: warning: excess elements in struct initializer
drivers/video/cirrusfb.c:544: warning: (near initialization for `clgen_hwswitch')
drivers/video/cirrusfb.c:545: warning: excess elements in struct initializer
drivers/video/cirrusfb.c:545: warning: (near initialization for `clgen_hwswitch')
drivers/video/cirrusfb.c:546: warning: excess elements in struct initializer
drivers/video/cirrusfb.c:546: warning: (near initialization for `clgen_hwswitch')
drivers/video/cirrusfb.c:548: warning: excess elements in struct initializer
drivers/video/cirrusfb.c:548: warning: (near initialization for `clgen_hwswitch')
drivers/video/cirrusfb.c: In function `clgen_set_mclk':
drivers/video/cirrusfb.c:1098: warning: implicit declaration of function `vga_rseq'
drivers/video/cirrusfb.c:1098: `CL_SEQR1E' undeclared (first use in this function)
drivers/video/cirrusfb.c:1098: (Each undeclared identifier is reported only once
drivers/video/cirrusfb.c:1098: for each function it appears in.)
drivers/video/cirrusfb.c:1099: warning: implicit declaration of function `vga_wseq'
drivers/video/cirrusfb.c:1100: `CL_SEQR1F' undeclared (first use in this function)
drivers/video/cirrusfb.c: In function `clgen_set_par':
drivers/video/cirrusfb.c:1133: warning: implicit declaration of function `vga_wcrt'
drivers/video/cirrusfb.c:1133: `VGA_CRTC_V_SYNC_END' undeclared (first use in this function)
drivers/video/cirrusfb.c:1137: `VGA_CRTC_H_TOTAL' undeclared (first use in this function)
drivers/video/cirrusfb.c:1140: `VGA_CRTC_H_DISP' undeclared (first use in this function)
drivers/video/cirrusfb.c:1143: `VGA_CRTC_H_BLANK_START' undeclared (first use in this function)
drivers/video/cirrusfb.c:1146: `VGA_CRTC_H_BLANK_END' undeclared (first use in this function)
drivers/video/cirrusfb.c:1149: `VGA_CRTC_H_SYNC_START' undeclared (first use in this function)
drivers/video/cirrusfb.c:1155: `VGA_CRTC_H_SYNC_END' undeclared (first use in this function)
drivers/video/cirrusfb.c:1158: `VGA_CRTC_V_TOTAL' undeclared (first use in this function)
drivers/video/cirrusfb.c:1176: `VGA_CRTC_OVERFLOW' undeclared (first use in this function)
drivers/video/cirrusfb.c:1184: `VGA_CRTC_MAX_SCAN' undeclared (first use in this function)
drivers/video/cirrusfb.c:1187: `VGA_CRTC_V_SYNC_START' undeclared (first use in this function)
drivers/video/cirrusfb.c:1193: `VGA_CRTC_V_DISP_END' undeclared (first use in this function)
drivers/video/cirrusfb.c:1196: `VGA_CRTC_V_BLANK_START' undeclared (first use in this function)
drivers/video/cirrusfb.c:1199: `VGA_CRTC_V_BLANK_END' undeclared (first use in this function)
drivers/video/cirrusfb.c:1202: `VGA_CRTC_LINE_COMPARE' undeclared (first use in this function)
drivers/video/cirrusfb.c:1217: `CL_CRT1A' undeclared (first use in this function)
drivers/video/cirrusfb.c:1224: `CL_SEQRB' undeclared (first use in this function)
drivers/video/cirrusfb.c:1235: `CL_SEQR1B' undeclared (first use in this function)
drivers/video/cirrusfb.c:1239: `VGA_CRTC_MODE' undeclared (first use in this function)
drivers/video/cirrusfb.c:1250: `VGA_CRTC_REGS' undeclared (first use in this function)
drivers/video/cirrusfb.c:1254: `VGA_SEQ_CHARACTER_MAP' undeclared (first use in this function)
drivers/video/cirrusfb.c:1262: `VGA_MIS_W' undeclared (first use in this function)
drivers/video/cirrusfb.c:1264: `VGA_CRTC_PRESET_ROW' undeclared (first use in this function)
drivers/video/cirrusfb.c:1265: `VGA_CRTC_CURSOR_START' undeclared (first use in this function)
drivers/video/cirrusfb.c:1266: `VGA_CRTC_CURSOR_END' undeclared (first use in this function)
drivers/video/cirrusfb.c:1277: warning: implicit declaration of function `vga_wgfx'
drivers/video/cirrusfb.c:1277: `VGA_GFX_MODE' undeclared (first use in this function)
drivers/video/cirrusfb.c:1289: `CL_SEQR7' undeclared (first use in this function)
drivers/video/cirrusfb.c:1310: `CL_SEQR1F' undeclared (first use in this function)
drivers/video/cirrusfb.c:1317: `CL_SEQRF' undeclared (first use in this function)
drivers/video/cirrusfb.c:1346: `VGA_PEL_MSK' undeclared (first use in this function)
drivers/video/cirrusfb.c:1351: `VGA_SEQ_MEMORY_MODE' undeclared (first use in this function)
drivers/video/cirrusfb.c:1352: `VGA_SEQ_PLANE_WRITE' undeclared (first use in this function)
drivers/video/cirrusfb.c:1599: `VGA_CRTC_OFFSET' undeclared (first use in this function)
drivers/video/cirrusfb.c:1604: `CL_CRT1B' undeclared (first use in this function)
drivers/video/cirrusfb.c:1610: `CL_CRT1D' undeclared (first use in this function)
drivers/video/cirrusfb.c:1612: `VGA_CRTC_CURSOR_HI' undeclared (first use in this function)
drivers/video/cirrusfb.c:1613: `VGA_CRTC_CURSOR_LO' undeclared (first use in this function)
drivers/video/cirrusfb.c:1614: `VGA_CRTC_UNDERLINE' undeclared (first use in this function)
drivers/video/cirrusfb.c:1616: warning: implicit declaration of function `vga_wattr'
drivers/video/cirrusfb.c:1616: `VGA_ATC_MODE' undeclared (first use in this function)
drivers/video/cirrusfb.c:1617: `VGA_ATC_OVERSCAN' undeclared (first use in this function)
drivers/video/cirrusfb.c:1618: `VGA_ATC_PLANE_ENABLE' undeclared (first use in this function)
drivers/video/cirrusfb.c:1619: `CL_AR33' undeclared (first use in this function)
drivers/video/cirrusfb.c:1620: `VGA_ATC_COLOR_PAGE' undeclared (first use in this function)
drivers/video/cirrusfb.c:1626: `VGA_GFX_SR_VALUE' undeclared (first use in this function)
drivers/video/cirrusfb.c:1627: `VGA_GFX_SR_ENABLE' undeclared (first use in this function)
drivers/video/cirrusfb.c:1628: `VGA_GFX_COMPARE_VALUE' undeclared (first use in this function)
drivers/video/cirrusfb.c:1629: `VGA_GFX_DATA_ROTATE' undeclared (first use in this function)
drivers/video/cirrusfb.c:1630: `VGA_GFX_PLANE_READ' undeclared (first use in this function)
drivers/video/cirrusfb.c:1631: `VGA_GFX_MISC' undeclared (first use in this function)
drivers/video/cirrusfb.c:1632: `VGA_GFX_COMPARE_MASK' undeclared (first use in this function)
drivers/video/cirrusfb.c:1633: `VGA_GFX_BIT_MASK' undeclared (first use in this function)
drivers/video/cirrusfb.c:1635: `CL_SEQR12' undeclared (first use in this function)
drivers/video/cirrusfb.c:1646: `VGA_SEQ_CLOCK_MODE' undeclared (first use in this function)
drivers/video/cirrusfb.c: In function `clgen_pan_display':
drivers/video/cirrusfb.c:1797: `VGA_CRTC_START_LO' undeclared (first use in this function)
drivers/video/cirrusfb.c:1798: `VGA_CRTC_START_HI' undeclared (first use in this function)
drivers/video/cirrusfb.c:1808: warning: implicit declaration of function `vga_rcrt'
drivers/video/cirrusfb.c:1808: `CL_CRT1B' undeclared (first use in this function)
drivers/video/cirrusfb.c:1816: `CL_CRT1D' undeclared (first use in this function)
drivers/video/cirrusfb.c:1822: `CL_AR33' undeclared (first use in this function)
drivers/video/cirrusfb.c: In function `clgen_blank':
drivers/video/cirrusfb.c:1858: `VGA_SEQ_CLOCK_MODE' undeclared (first use in this function)
drivers/video/cirrusfb.c:1864: `CL_GRE' undeclared (first use in this function)
drivers/video/cirrusfb.c: In function `init_vgachip':
drivers/video/cirrusfb.c:1931: `CL_CRT51' undeclared (first use in this function)
drivers/video/cirrusfb.c:1933: `CL_GR2F' undeclared (first use in this function)
drivers/video/cirrusfb.c:1934: `CL_GR33' undeclared (first use in this function)
drivers/video/cirrusfb.c:1935: `CL_GR31' undeclared (first use in this function)
drivers/video/cirrusfb.c:1961: `CL_VSSM' undeclared (first use in this function)
drivers/video/cirrusfb.c:1962: `CL_POS102' undeclared (first use in this function)
drivers/video/cirrusfb.c:1966: `CL_VSSM2' undeclared (first use in this function)
drivers/video/cirrusfb.c:1968: `CL_SEQR0' undeclared (first use in this function)
drivers/video/cirrusfb.c:1970: `VGA_SEQ_CLOCK_MODE' undeclared (first use in this function)
drivers/video/cirrusfb.c:1971: `VGA_MIS_W' undeclared (first use in this function)
drivers/video/cirrusfb.c:1974: `CL_SEQR6' undeclared (first use in this function)
drivers/video/cirrusfb.c:1980: `CL_SEQRF' undeclared (first use in this function)
drivers/video/cirrusfb.c:1988: `CL_SEQR16' undeclared (first use in this function)
drivers/video/cirrusfb.c:1993: `VGA_SEQ_PLANE_WRITE' undeclared (first use in this function)
drivers/video/cirrusfb.c:1994: `VGA_SEQ_CHARACTER_MAP' undeclared (first use in this function)
drivers/video/cirrusfb.c:1995: `VGA_SEQ_MEMORY_MODE' undeclared (first use in this function)
drivers/video/cirrusfb.c:1999: `CL_SEQR7' undeclared (first use in this function)
drivers/video/cirrusfb.c:2003: `CL_SEQR10' undeclared (first use in this function)
drivers/video/cirrusfb.c:2004: `CL_SEQR11' undeclared (first use in this function)
drivers/video/cirrusfb.c:2005: `CL_SEQR12' undeclared (first use in this function)
drivers/video/cirrusfb.c:2006: `CL_SEQR13' undeclared (first use in this function)
drivers/video/cirrusfb.c:2010: `CL_SEQR17' undeclared (first use in this function)
drivers/video/cirrusfb.c:2011: `CL_SEQR18' undeclared (first use in this function)
drivers/video/cirrusfb.c:2016: `CL_SEQR1F' undeclared (first use in this function)
drivers/video/cirrusfb.c:2018: `VGA_CRTC_PRESET_ROW' undeclared (first use in this function)
drivers/video/cirrusfb.c:2019: `VGA_CRTC_CURSOR_START' undeclared (first use in this function)
drivers/video/cirrusfb.c:2020: `VGA_CRTC_CURSOR_END' undeclared (first use in this function)
drivers/video/cirrusfb.c:2021: `VGA_CRTC_START_HI' undeclared (first use in this function)
drivers/video/cirrusfb.c:2022: `VGA_CRTC_START_LO' undeclared (first use in this function)
drivers/video/cirrusfb.c:2023: `VGA_CRTC_CURSOR_HI' undeclared (first use in this function)
drivers/video/cirrusfb.c:2024: `VGA_CRTC_CURSOR_LO' undeclared (first use in this function)
drivers/video/cirrusfb.c:2026: `VGA_CRTC_UNDERLINE' undeclared (first use in this function)
drivers/video/cirrusfb.c:2027: `VGA_CRTC_MODE' undeclared (first use in this function)
drivers/video/cirrusfb.c:2028: `VGA_CRTC_LINE_COMPARE' undeclared (first use in this function)
drivers/video/cirrusfb.c:2030: `CL_CRT1B' undeclared (first use in this function)
drivers/video/cirrusfb.c:2032: `VGA_GFX_SR_VALUE' undeclared (first use in this function)
drivers/video/cirrusfb.c:2033: `VGA_GFX_SR_ENABLE' undeclared (first use in this function)
drivers/video/cirrusfb.c:2034: `VGA_GFX_COMPARE_VALUE' undeclared (first use in this function)
drivers/video/cirrusfb.c:2035: `VGA_GFX_DATA_ROTATE' undeclared (first use in this function)
drivers/video/cirrusfb.c:2036: `VGA_GFX_PLANE_READ' undeclared (first use in this function)
drivers/video/cirrusfb.c:2037: `VGA_GFX_MODE' undeclared (first use in this function)
drivers/video/cirrusfb.c:2038: `VGA_GFX_MISC' undeclared (first use in this function)
drivers/video/cirrusfb.c:2039: `VGA_GFX_COMPARE_MASK' undeclared (first use in this function)
drivers/video/cirrusfb.c:2040: `VGA_GFX_BIT_MASK' undeclared (first use in this function)
drivers/video/cirrusfb.c:2042: `CL_GRB' undeclared (first use in this function)
drivers/video/cirrusfb.c:2046: `CL_GRC' undeclared (first use in this function)
drivers/video/cirrusfb.c:2047: `CL_GRD' undeclared (first use in this function)
drivers/video/cirrusfb.c:2048: `CL_GRE' undeclared (first use in this function)
drivers/video/cirrusfb.c:2052: `VGA_ATC_PALETTE0' undeclared (first use in this function)
drivers/video/cirrusfb.c:2053: `VGA_ATC_PALETTE1' undeclared (first use in this function)
drivers/video/cirrusfb.c:2054: `VGA_ATC_PALETTE2' undeclared (first use in this function)
drivers/video/cirrusfb.c:2055: `VGA_ATC_PALETTE3' undeclared (first use in this function)
drivers/video/cirrusfb.c:2056: `VGA_ATC_PALETTE4' undeclared (first use in this function)
drivers/video/cirrusfb.c:2057: `VGA_ATC_PALETTE5' undeclared (first use in this function)
drivers/video/cirrusfb.c:2058: `VGA_ATC_PALETTE6' undeclared (first use in this function)
drivers/video/cirrusfb.c:2059: `VGA_ATC_PALETTE7' undeclared (first use in this function)
drivers/video/cirrusfb.c:2060: `VGA_ATC_PALETTE8' undeclared (first use in this function)
drivers/video/cirrusfb.c:2061: `VGA_ATC_PALETTE9' undeclared (first use in this function)
drivers/video/cirrusfb.c:2062: `VGA_ATC_PALETTEA' undeclared (first use in this function)
drivers/video/cirrusfb.c:2063: `VGA_ATC_PALETTEB' undeclared (first use in this function)
drivers/video/cirrusfb.c:2064: `VGA_ATC_PALETTEC' undeclared (first use in this function)
drivers/video/cirrusfb.c:2065: `VGA_ATC_PALETTED' undeclared (first use in this function)
drivers/video/cirrusfb.c:2066: `VGA_ATC_PALETTEE' undeclared (first use in this function)
drivers/video/cirrusfb.c:2067: `VGA_ATC_PALETTEF' undeclared (first use in this function)
drivers/video/cirrusfb.c:2069: `VGA_ATC_MODE' undeclared (first use in this function)
drivers/video/cirrusfb.c:2070: `VGA_ATC_OVERSCAN' undeclared (first use in this function)
drivers/video/cirrusfb.c:2071: `VGA_ATC_PLANE_ENABLE' undeclared (first use in this function)
drivers/video/cirrusfb.c:2073: `VGA_ATC_COLOR_PAGE' undeclared (first use in this function)
drivers/video/cirrusfb.c:2075: `VGA_PEL_MSK' undeclared (first use in this function)
drivers/video/cirrusfb.c: In function `clgen_set_disp':
drivers/video/cirrusfb.c:2185: dereferencing pointer to incomplete type
drivers/video/cirrusfb.c:2242: dereferencing pointer to incomplete type
drivers/video/cirrusfb.c:2242: `fbcon_dummy' undeclared (first use in this function)
drivers/video/cirrusfb.c:2243: dereferencing pointer to incomplete type
drivers/video/cirrusfb.c: In function `clgen_get_memsize':
drivers/video/cirrusfb.c:2430: `CL_SEQRF' undeclared (first use in this function)
drivers/video/cirrusfb.c: In function `clgen_pci_setup':
drivers/video/cirrusfb.c:2543: warning: implicit declaration of function `pcibios_write_config_dword'
drivers/video/cirrusfb.c: In function `clgenfb_init':
drivers/video/cirrusfb.c:2789: `fbgen_switch' undeclared (first use in this function)
drivers/video/cirrusfb.c:2790: `fbgen_update_var' undeclared (first use in this function)
drivers/video/cirrusfb.c:2811: warning: implicit declaration of function `fbgen_do_set_var'
drivers/video/cirrusfb.c:2818: invalid use of undefined type `struct display'
drivers/video/cirrusfb.c:2819: warning: implicit declaration of function `fbgen_set_disp'
drivers/video/cirrusfb.c:2820: warning: implicit declaration of function `do_install_cmap'
drivers/video/cirrusfb.c: In function `WGen':
drivers/video/cirrusfb.c:2923: `VGA_PEL_IR' undeclared (first use in this function)
drivers/video/cirrusfb.c:2923: `VGA_PEL_D' undeclared (first use in this function)
drivers/video/cirrusfb.c:2927: warning: implicit declaration of function `vga_w'
drivers/video/cirrusfb.c: In function `RGen':
drivers/video/cirrusfb.c:2938: `VGA_PEL_IR' undeclared (first use in this function)
drivers/video/cirrusfb.c:2938: `VGA_PEL_D' undeclared (first use in this function)
drivers/video/cirrusfb.c:2942: warning: implicit declaration of function `vga_r'
drivers/video/cirrusfb.c: In function `AttrOn':
drivers/video/cirrusfb.c:2952: `CL_CRT24' undeclared (first use in this function)
drivers/video/cirrusfb.c:2955: `VGA_ATT_IW' undeclared (first use in this function)
drivers/video/cirrusfb.c:2956: `VGA_ATT_R' undeclared (first use in this function)
drivers/video/cirrusfb.c: In function `WHDR':
drivers/video/cirrusfb.c:2981: `VGA_PEL_MSK' undeclared (first use in this function)
drivers/video/cirrusfb.c:2984: `VGA_PEL_IW' undeclared (first use in this function)
drivers/video/cirrusfb.c: In function `WClut':
drivers/video/cirrusfb.c:3041: `VGA_PEL_D' undeclared (first use in this function)
drivers/video/cirrusfb.c:3044: `VGA_PEL_IW' undeclared (first use in this function)
drivers/video/cirrusfb.c: In function `clgen_WaitBLT':
drivers/video/cirrusfb.c:3097: warning: implicit declaration of function `vga_rgfx'
drivers/video/cirrusfb.c:3097: `CL_GR31' undeclared (first use in this function)
drivers/video/cirrusfb.c: In function `clgen_BitBLT':
drivers/video/cirrusfb.c:3155: `CL_GR24' undeclared (first use in this function)
drivers/video/cirrusfb.c:3156: `CL_GR25' undeclared (first use in this function)
drivers/video/cirrusfb.c:3157: `CL_GR26' undeclared (first use in this function)
drivers/video/cirrusfb.c:3158: `CL_GR27' undeclared (first use in this function)
drivers/video/cirrusfb.c:3161: `CL_GR20' undeclared (first use in this function)
drivers/video/cirrusfb.c:3162: `CL_GR21' undeclared (first use in this function)
drivers/video/cirrusfb.c:3165: `CL_GR22' undeclared (first use in this function)
drivers/video/cirrusfb.c:3166: `CL_GR23' undeclared (first use in this function)
drivers/video/cirrusfb.c:3169: `CL_GR28' undeclared (first use in this function)
drivers/video/cirrusfb.c:3170: `CL_GR29' undeclared (first use in this function)
drivers/video/cirrusfb.c:3171: `CL_GR2A' undeclared (first use in this function)
drivers/video/cirrusfb.c:3174: `CL_GR2C' undeclared (first use in this function)
drivers/video/cirrusfb.c:3175: `CL_GR2D' undeclared (first use in this function)
drivers/video/cirrusfb.c:3176: `CL_GR2E' undeclared (first use in this function)
drivers/video/cirrusfb.c:3179: `CL_GR30' undeclared (first use in this function)
drivers/video/cirrusfb.c:3182: `CL_GR32' undeclared (first use in this function)
drivers/video/cirrusfb.c:3185: `CL_GR31' undeclared (first use in this function)
drivers/video/cirrusfb.c: In function `clgen_RectFill':
drivers/video/cirrusfb.c:3215: `CL_GR24' undeclared (first use in this function)
drivers/video/cirrusfb.c:3216: `CL_GR25' undeclared (first use in this function)
drivers/video/cirrusfb.c:3217: `CL_GR26' undeclared (first use in this function)
drivers/video/cirrusfb.c:3218: `CL_GR27' undeclared (first use in this function)
drivers/video/cirrusfb.c:3221: `CL_GR20' undeclared (first use in this function)
drivers/video/cirrusfb.c:3222: `CL_GR21' undeclared (first use in this function)
drivers/video/cirrusfb.c:3225: `CL_GR22' undeclared (first use in this function)
drivers/video/cirrusfb.c:3226: `CL_GR23' undeclared (first use in this function)
drivers/video/cirrusfb.c:3229: `CL_GR28' undeclared (first use in this function)
drivers/video/cirrusfb.c:3230: `CL_GR29' undeclared (first use in this function)
drivers/video/cirrusfb.c:3231: `CL_GR2A' undeclared (first use in this function)
drivers/video/cirrusfb.c:3234: `CL_GR2C' undeclared (first use in this function)
drivers/video/cirrusfb.c:3235: `CL_GR2D' undeclared (first use in this function)
drivers/video/cirrusfb.c:3236: `CL_GR2E' undeclared (first use in this function)
drivers/video/cirrusfb.c:3240: `VGA_GFX_SR_VALUE' undeclared (first use in this function)
drivers/video/cirrusfb.c:3241: `VGA_GFX_SR_ENABLE' undeclared (first use in this function)
drivers/video/cirrusfb.c:3245: `CL_GR10' undeclared (first use in this function)
drivers/video/cirrusfb.c:3246: `CL_GR11' undeclared (first use in this function)
drivers/video/cirrusfb.c:3252: `CL_GR12' undeclared (first use in this function)
drivers/video/cirrusfb.c:3253: `CL_GR13' undeclared (first use in this function)
drivers/video/cirrusfb.c:3254: `CL_GR14' undeclared (first use in this function)
drivers/video/cirrusfb.c:3255: `CL_GR15' undeclared (first use in this function)
drivers/video/cirrusfb.c:3260: `CL_GR30' undeclared (first use in this function)
drivers/video/cirrusfb.c:3263: `CL_GR32' undeclared (first use in this function)
drivers/video/cirrusfb.c:3266: `CL_GR31' undeclared (first use in this function)
drivers/video/cirrusfb.c: At top level:
drivers/video/cirrusfb.c:412: storage size of `disp' isn't known
drivers/video/cirrusfb.c:536: storage size of `clgen_hwswitch' isn't known
drivers/video/cirrusfb.c:3109: warning: `clgen_BitBLT' defined but not used
drivers/video/cirrusfb.c:3200: warning: `clgen_RectFill' defined but not used
make[2]: *** [drivers/video/cirrusfb.o] Error 1
make[1]: *** [drivers/video] Error 2
make: *** [drivers] Error 2
 

--=-+WaMOAzODiqjwBZCoDEC--

