Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262972AbUCKJWz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 04:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262975AbUCKJWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 04:22:55 -0500
Received: from 69-90-55-107.fastdsl.ca ([69.90.55.107]:9344 "EHLO
	TMA-1.brad-x.com") by vger.kernel.org with ESMTP id S262972AbUCKJWv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 04:22:51 -0500
Message-ID: <40503120.9000008@brad-x.com>
Date: Thu, 11 Mar 2004 04:28:00 -0500
From: Brad Laue <brad@brad-x.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040222
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ksoftirqd using mysteriously high amounts of CPU time
References: <404F85A6.6070505@brad-x.com> <20040310155712.7472e31c.akpm@osdl.org> <4050271C.3070103@brad-x.com>
In-Reply-To: <4050271C.3070103@brad-x.com>
Content-Type: multipart/mixed;
 boundary="------------000306080108080803030207"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000306080108080803030207
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Brad Laue wrote:
> Hopefully the attached shows some irregularity. If not, I'll have to 
> reply back in a few weeks when the problem recurs over the course of time.

And without further ado, the attachment. It's been a long day. :)

Brad

--------------000306080108080803030207
Content-Type: text/plain;
 name="profile.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="profile.txt"

c0122bf0 current_kernel_time                           2   0.0312
c0122d20 local_bh_enable                               2   0.0139
c0137800 unlock_page                                   2   0.0208
c013ef10 __kmalloc                                     2   0.0156
c0155630 mark_buffer_dirty                             2   0.0250
c0165760 poll_freewait                                 2   0.0250
c01df2b0 xfs_ichgtime                                  2   0.0075
c0202780 linvfs_get_block_core                         2   0.0027
c0205310 linvfs_write                                  2   0.0069
c0216e90 fast_copy_page                                2   0.0078
c0244b90 tty_write                                     2   0.0030
c0246020 tty_poll                                      2   0.0156
c0248670 n_tty_receive_buf                             2   0.0005
c024b1e0 pty_unthrottle                                2   0.0208
c024b240 pty_write                                     2   0.0043
c0109354 system_call                                   3   0.0682
c0152e70 vfs_write                                     3   0.0099
c0157cd0 alloc_buffer_head                             3   0.0312
c01657b0 __pollwait                                    3   0.0144
c016e100 dnotify_parent                                3   0.0156
c01b1e50 xfs_bmapi                                     3   0.0006
c024a3a0 normal_poll                                   3   0.0088
c0107090 cpu_idle                                      4   0.0625
c0153e60 fget                                          4   0.0625
c0165c60 sys_select                                    4   0.0032
c0216e30 fast_clear_page                               4   0.0417
c0139280 generic_file_aio_write_nolock                 5   0.0019
c0209d60 xfs_write                                     6   0.0028
c011ba10 __wake_up                                     7   0.0729
c0165960 do_select                                     8   0.0111
c0249920 read_chan                                     9   0.0042
c0156170 __block_prepare_write                        12   0.0117
c02173c0 __copy_from_user_ll                          12   0.0938
c010b570 handle_IRQ_event                             13   0.1161
c0187210 write_profile                                14   0.2188
c011b3c0 schedule                                     15   0.0107
c0217350 __copy_to_user_ll                            47   0.4196
c0122c80 do_softirq                                  136   0.8500
c0107030 default_idle                               9222 192.1250
00000000 total                                      9611   0.0063

--------------000306080108080803030207--
