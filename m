Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262486AbTCRQN3>; Tue, 18 Mar 2003 11:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262490AbTCRQN3>; Tue, 18 Mar 2003 11:13:29 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:17644 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S262486AbTCRQN2>; Tue, 18 Mar 2003 11:13:28 -0500
Date: Tue, 18 Mar 2003 17:24:25 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: top Stack (l)users for 2.5.65
Message-ID: <20030318162425.GA10424@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.44.0303171429040.2827-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0303171429040.2827-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

32 functions using >=1k of kernel stack on i386

The list is _much_ shorter than the 2.5.64 one. But I don't know how
to interpret that yet.

oldconfig created about the same amount of work as allyesconfig and
hand-pruning of breaking drivers. The resulting .config might have
changed a lot, enough to account for 19 lost functions.

0xc01b6994 presto_get_fileid:                            sub    $0x1164,%esp
0xc01b5634 presto_copy_kml_tail:                         sub    $0x1018,%esp
0xc06b2704 i2o_proc_read_ddm_table:                      sub    $0xb48,%esp
0xc056daf9 v4l_compat_translate_ioctl:                   sub    $0x924,%esp
0xc05beed6 ide_unregister:                               sub    $0x8a0,%esp
0xc05403d4 writerids:                                    sub    $0x820,%esp
0xc05855f4 w9966_v4l_read:                               sub    $0x820,%esp
0xc06b53f4 i2o_proc_read_lan_alt_addr:                   sub    $0x81c,%esp
0xc06b4c74 i2o_proc_read_lan_mcast_addr:                 sub    $0x81c,%esp
0xc0540224 readrids:                                     sub    $0x810,%esp
0xc06b2bb4 i2o_proc_read_groups:                         sub    $0x810,%esp
0xc0105409 huft_build:                                   sub    $0x598,%esp
0xc0106e59 huft_build:                                   sub    $0x598,%esp
0xc023e794 dohash:                                       sub    $0x580,%esp
0xc0438ad4 ida_ioctl:                                    sub    $0x53c,%esp
0xc0107bd4 inflate_dynamic:                              sub    $0x52c,%esp
0xc0106104 inflate_dynamic:                              sub    $0x51c,%esp
0xc08eb604 device_new_if:                                sub    $0x518,%esp
0xc01ad654 presto_ioctl:                                 sub    $0x4fc,%esp
0xc05ced04 ide_config:                                   sub    $0x494,%esp
0xc0107a67 inflate_fixed:                                sub    $0x490,%esp
0xc0105f97 inflate_fixed:                                sub    $0x490,%esp
0xc08e7bf9 br_ioctl_device:                              sub    $0x490,%esp
0xc0425034 parport_config:                               sub    $0x47c,%esp
0xc07c6d04 ixj_config:                                   sub    $0x478,%esp
0xc0333b66 sha512_transform:                             sub    $0x440,%esp
0xc09326e4 gss_pipe_downcall:                            sub    $0x43c,%esp
0xc02a8c74 ciGetLeafPrefixKey:                           sub    $0x41c,%esp
0xc064a804 aic7xxx_detect:                               sub    $0x404,%esp
0xc050a998 hex_dump:                                     sub    $0x400,%esp
0xc0323942 befs_warning:                                 sub    $0x400,%esp
0xc03238f2 befs_error:                                   sub    $0x400,%esp

Jörn

-- 
Courage is not the absence of fear, but rather the judgement that
something else is more important than fear.
-- Ambrose Redmoon
