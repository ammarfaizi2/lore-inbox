Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263373AbTDVS5D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 14:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263374AbTDVS5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 14:57:03 -0400
Received: from ridcully.bzimage.de ([213.146.113.136]:40320 "EHLO
	ridcully.bzimage.de") by vger.kernel.org with ESMTP id S263373AbTDVS4e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 14:56:34 -0400
Date: Tue, 22 Apr 2003 21:08:37 +0200
From: Norbert Tretkowski <tretkowski@bzimage.de>
To: linux-kernel@vger.kernel.org
Subject: [2.5.68] cirrusfb on alpha does not compile
Message-ID: <20030422190837.GA20925@rollcage.bzimage.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
Mail-Copies-To: never
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  gcc -Wp,-MD,drivers/video/.cirrusfb.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-alia
sing -fno-common -pipe -mno-fp-regs -ffixed-8 -msmall-data -mcpu=ev56 -Wa,-mev6 -fomit-frame-pointer -nostdinc -iwithprefix in
clude    -DKBUILD_BASENAME=cirrusfb -DKBUILD_MODNAME=cirrusfb -c -o drivers/video/cirrusfb.o drivers/video/cirrusfb.c
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
make[3]: *** [drivers/video/cirrusfb.o] Error 1
make[2]: *** [drivers/video] Error 2
make[1]: *** [drivers] Error 2
make: *** [vmlinux] Error 2

.config is attached

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-2.5.68"

#
# Automatically generated make config: don't edit
#
CONFIG_ALPHA=y
CONFIG_MMU=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y

#
# System setup
#
# CONFIG_ALPHA_GENERIC is not set
# CONFIG_ALPHA_ALCOR is not set
# CONFIG_ALPHA_XL is not set
# CONFIG_ALPHA_BOOK1 is not set
# CONFIG_ALPHA_AVANTI_CH is not set
# CONFIG_ALPHA_CABRIOLET is not set
# CONFIG_ALPHA_DP264 is not set
# CONFIG_ALPHA_EB164 is not set
# CONFIG_ALPHA_EB64P_CH is not set
# CONFIG_ALPHA_EB66 is not set
# CONFIG_ALPHA_EB66P is not set
# CONFIG_ALPHA_EIGER is not set
# CONFIG_ALPHA_JENSEN is not set
# CONFIG_ALPHA_LX164 is not set
# CONFIG_ALPHA_LYNX is not set
# CONFIG_ALPHA_MARVEL is not set
CONFIG_ALPHA_MIATA=y
# CONFIG_ALPHA_MIKASA is not set
# CONFIG_ALPHA_NAUTILUS is not set
# CONFIG_ALPHA_NONAME_CH is not set
# CONFIG_ALPHA_NORITAKE is not set
# CONFIG_ALPHA_PC164 is not set
# CONFIG_ALPHA_P2K is not set
# CONFIG_ALPHA_RAWHIDE is not set
# CONFIG_ALPHA_RUFFIAN is not set
# CONFIG_ALPHA_RX164 is not set
# CONFIG_ALPHA_SX164 is not set
# CONFIG_ALPHA_SABLE is not set
# CONFIG_ALPHA_SHARK is not set
# CONFIG_ALPHA_TAKARA is not set
# CONFIG_ALPHA_TITAN is not set
# CONFIG_ALPHA_WILDFIRE is not set
CONFIG_ISA=y
CONFIG_PCI=y
CONFIG_ALPHA_EV5=y
CONFIG_ALPHA_CIA=y
CONFIG_ALPHA_EV56=y
CONFIG_ALPHA_PYXIS=y
CONFIG_ALPHA_SRM=y
CONFIG_EARLY_PRINTK=y
# CONFIG_DISCONTIGMEM is not set
CONFIG_VERBOSE_MCHECK=y
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y
# CONFIG_HOTPLUG is not set
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_SRM_ENV=m
# CONFIG_BINFMT_AOUT is not set
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set
# CONFIG_BINFMT_EM86 is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Plug and Play support
#
# CONFIG_PNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_DEV_XD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# ATA/ATAPI/MFM/RLL support
#
# CONFIG_IDE is not set

#
# SCSI support
#
CONFIG_SCSI=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_REPORT_LUNS is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_NCR53C8XX is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
CONFIG_SCSI_QLOGIC_ISP_NEW=y
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=m
# CONFIG_PACKET_MMAP is not set
CONFIG_NETLINK_DEV=m
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_UNIX=m
CONFIG_NET_KEY=m
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set

#
# IP: Netfilter Configuration
#
# CONFIG_IP_NF_CONNTRACK is not set
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=m
# CONFIG_IP_NF_MATCH_LIMIT is not set
# CONFIG_IP_NF_MATCH_MAC is not set
# CONFIG_IP_NF_MATCH_PKTTYPE is not set
# CONFIG_IP_NF_MATCH_MARK is not set
# CONFIG_IP_NF_MATCH_MULTIPORT is not set
# CONFIG_IP_NF_MATCH_TOS is not set
# CONFIG_IP_NF_MATCH_ECN is not set
# CONFIG_IP_NF_MATCH_DSCP is not set
# CONFIG_IP_NF_MATCH_AH_ESP is not set
# CONFIG_IP_NF_MATCH_LENGTH is not set
# CONFIG_IP_NF_MATCH_TTL is not set
# CONFIG_IP_NF_MATCH_TCPMSS is not set
# CONFIG_IP_NF_MATCH_UNCLEAN is not set
# CONFIG_IP_NF_MATCH_OWNER is not set
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
# CONFIG_IP_NF_TARGET_MIRROR is not set
# CONFIG_IP_NF_MANGLE is not set
CONFIG_IP_NF_TARGET_LOG=m
# CONFIG_IP_NF_TARGET_ULOG is not set
# CONFIG_IP_NF_TARGET_TCPMSS is not set
# CONFIG_IP_NF_ARPTABLES is not set
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
# CONFIG_IPV6 is not set
# CONFIG_XFRM_USER is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=y
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=m
# CONFIG_ETHERTAP is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_MII is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set

#
# Tulip family network device support
#
CONFIG_NET_TULIP=y
# CONFIG_DE2104X is not set
CONFIG_TULIP=m
# CONFIG_TULIP_MWI is not set
# CONFIG_TULIP_MMIO is not set
# CONFIG_DE4X5 is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_DM9102 is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
# CONFIG_NET_PCI is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices (depends on LLC=y)
#
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# ISDN subsystem
#
# CONFIG_ISDN_BOOL is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
# CONFIG_UNIX98_PTYS is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# I2C Hardware Sensors Mainboard support
#

#
# I2C Hardware Sensors Chip support
#
# CONFIG_I2C_SENSOR is not set

#
# Mice
#
CONFIG_BUSMOUSE=m
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_NVRAM is not set
CONFIG_RTC=m
# CONFIG_GEN_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# File systems
#
CONFIG_EXT2_FS=m
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
# CONFIG_FAT_FS is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_TMPFS is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_NFS_V4 is not set
# CONFIG_NFSD is not set
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
# CONFIG_EXPORTFS is not set
CONFIG_SUNRPC=m
# CONFIG_SUNRPC_GSS is not set
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp850"
CONFIG_CIFS=m
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_OSF_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=m
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Graphics support
#
CONFIG_FB=y
CONFIG_FB_CIRRUS=y
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_TGA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Logo configuration
#
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB is not set

#
# Bluetooth support
#
# CONFIG_BT is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
# CONFIG_ALPHA_LEGACY_START_ADDRESS is not set
CONFIG_DEBUG_KERNEL=y
# CONFIG_MATHEMU is not set
# CONFIG_DEBUG_SLAB is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_RWLOCK is not set
# CONFIG_DEBUG_SEMAPHORE is not set

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Library routines
#
# CONFIG_CRC32 is not set

--EeQfGwPcQSOJBaQU--
