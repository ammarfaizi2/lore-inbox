Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262768AbTIVEXN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 00:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262769AbTIVEXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 00:23:13 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:41707 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262768AbTIVEXJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 00:23:09 -0400
Date: Mon, 22 Sep 2003 06:23:08 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Chris Rivera <cmrivera@ufl.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE]  slab information utility
Message-ID: <20030922042308.GA8691@DUK2.13thfloor.at>
Mail-Followup-To: Chris Rivera <cmrivera@ufl.edu>,
	linux-kernel@vger.kernel.org
References: <1064199786.1199.29.camel@boobies.awol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1064199786.1199.29.camel@boobies.awol.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 21, 2003 at 11:03:06PM -0400, Chris Rivera wrote:
> Robert Love and I would like to announce the release of a new procps
> utility, slabtop.  Slabtop displays detail kernel slab layer information
> in real time.  The look of slabtop matches top's.  Slabtop displays a
> statistics header along with the ?top? caches based on a sort criteria. 

sounds good, downloaded the .src.rpm ... rebuilt and installed.

finally slabtop gives me an empty screen :( ...

# slabtop >x.log 2>&1
# echo $?
0

0000000: 756e 7265 636f 676e 697a 6162 6c65 2064  unrecognizable d
0000010: 6174 6120 696e 2073 6c61 6269 6e66 6f21  ata in slabinfo!
0000020: 0a65 7272 6f72 2072 6561 6469 6e67 2073  .error reading s
0000030: 6c61 6269 6e66 6f21 0a1b 2842 1b29 301b  labinfo!..(B.)0.
0000040: 5b3f 3130 3439 681b 5b31 3b32 3472 1b5b  [?1049h.[1;24r.[
0000050: 6d0f 1b5b 346c 1b5b 3f37 68              m..[4l.[?7h

best,
Herbert

cat /proc/slabinfo

slabinfo - version: 1.1 (statistics) (SMP)
kmem_cache            72     72    164    3    3    1 :     72      72     3    0    0 :  252  126 :     20      3      0      0
ip_fib_hash           32    144     24    1    1    1 :    144    1377     1    0    0 :  252  126 :    144     14    125      0
tcp_tw_bucket         74     74    104    2    2    1 :    370  165470   753  751    0 :  252  126 : 132075   3851 135164      5
tcp_bind_bucket      288    288     24    2    2    1 :    432  341599    54   52    0 :  252  126 : 109441   3012 112362     13
tcp_open_request      59     59     64    1    1    1 :    295  155059  1704 1703    0 :  252  126 : 158022   4844 161158      4
inet_peer_cache      154    154     48    2    2    1 :    231  107344    48   46    0 :  252  126 :  12380   1292  13615      0
ip_dst_cache         491    594    176   27   27    1 :   2486  685730   983  956    0 :  252  126 : 555443   7439 560414   1225
arp_cache             64     64    120    2    2    1 :    128   30165   164  162    0 :  252  126 :   8386   1158   9376      0
dm-snapshot-in       128    154     48    2    2    1 :    154     154     2    0    0 :  252  126 :    126      4      0      0
dm-snapshot-ex         0      0     24    0    0    1 :      0       0     0    0    0 :  252  126 :      0      0      0      0
kcopyd-jobs          512    513    200   27   27    1 :    513     513    27    0    0 :  252  126 :    485     54      0      0
dm io                  0      0     36    0    0    1 :      0       0     0    0    0 :  252  126 :      0      0      0      0
blkdev_requests     7168   7200     96  180  180    1 :   8240    8240   206   26    0 :  252  126 :   7986    412   1017      7
nfs_write_data         0      0    352    0    0    1 :      0       0     0    0    0 :  124   62 :      0      0      0      0
nfs_read_data          0      0    336    0    0    1 :      0       0     0    0    0 :  124   62 :      0      0      0      0
nfs_page               0      0     96    0    0    1 :      0       0     0    0    0 :  252  126 :      0      0      0      0
devfsd_event         250    250     28    2    2    1 :    250   60649   385  383    0 :  252  126 :   1933    923   2471      0
journal_head         338   7772     56   15  116    1 :  56615 18277414 34518 34402    0 :  252  126 : 36746722 197015 36788548 120579
revoke_table           5    169     20    1    1    1 :    130     504     1    0    0 :  252  126 :      2      5      1      0
revoke_record        144    144     24    1    1    1 :   1566  190196   635  634    0 :  252  126 : 100326   2560 101686    565
dnotify_cache          0      0     28    0    0    1 :      0       0     0    0    0 :  252  126 :      0      0      0      0
file_lock_cache      185    185    104    5    5    1 :    370  502502   409  404    0 :  252  126 : 13090074   6934 13096557      9
fasync_cache           0      0     24    0    0    1 :      0       0     0    0    0 :  252  126 :      0      0      0      0
uid_cache             37    202     36    2    2    1 :    202   48253     2    0    0 :  252  126 :   4397    514   4874      0
skbuff_head_cache    449    575    172   25   25    1 :    759 2219495   118   93    0 :  252  126 : 2268621  18691 2276387  10575
sock                 660    846    832   94   94    2 :    981  632340  1834 1740    0 :  124   62 : 5980366  14523 5989500   3062
sigqueue             144    270    140    7   10    1 :    270 2683274  5989 5979    0 :  252  126 : 42613190  45635 42639029  13800
kiobuf                 0      0     64    0    0    1 :      0       0     0    0    0 :  252  126 :      0      0      0      0
cdev_cache            23    154     48    2    2    1 :    462   27600    10    8    0 :  252  126 :   1047    260   1273      1
bdev_cache            39    177     64    3    3    1 :    413    1697     7    4    0 :  252  126 :    411     26    390      1
mnt_cache             43    168     68    3    3    1 :    168    2415     3    0    0 :  252  126 :     55     27     45      0
inode_cache        74617 126616    492 15825 15827    1 : 729880 13731739 1099328 10083    0 :  124   62 : 19302616 2279366 20198830 209286
dentry_cache       35950 181104    116 5325 5488    1 : 1381446 52642301 865697 15156    0 :  252  126 : 58666873 1923444 59286660 402106
filp                5159   5202    112  153  153    1 :   5202    5539   153    0    0 :  252  126 :   4994    318      0      0
names_cache            9      9   4096    9    9    1 :     66   36459 25184 25175    0 :   60   30 : 130868604  56934 130900352      2
buffer_head       177731 198801    104 5373 5373    1 : 548303 14901772 22466 17093    0 :  252  126 : 19531729 157026 19423681  65138
mm_struct            479    486    144   18   18    1 :    513  801021    40   22    0 :  252  126 : 845646   7088 852440     44
vm_area_struct     13601  16200     76  324  324    1 :  16850 15741099  2348 2024    0 :  252  126 : 104593256 129204 104596469 110318
fs_cache             546    588     44    7    7    1 :    588  855766     8    1    0 :  252  126 : 845713   7019 852466     50
files_cache          387    387    424   43   43    1 :    414  395867   177  134    0 :  124   62 : 845396   7506 852245    271
signal_act           288    348   1344  114  116    1 :    366  194181  1825 1709    0 :   60   30 : 843323  11233 851105   1403
size-131072(DMA)       0      0 131072    0    0   32 :      0       0     0    0    0 :    0    0 :      0      0      0      0
size-131072            0      0 131072    0    0   32 :      0       0     0    0    0 :    0    0 :      0      0      0      0
size-65536(DMA)        0      0  65536    0    0   16 :      0       0     0    0    0 :    0    0 :      0      0      0      0
size-65536             0      0  65536    0    0   16 :      0       0     0    0    0 :    0    0 :      0      0      0      0
size-32768(DMA)        0      0  32768    0    0    8 :      0       0     0    0    0 :    0    0 :      0      0      0      0
size-32768             2      2  32768    2    2    8 :      3       3     3    1    0 :    0    0 :      0      0      0      0
size-16384(DMA)        0      0  16384    0    0    4 :      0       0     0    0    0 :    0    0 :      0      0      0      0
size-16384             2      2  16384    2    2    4 :      6    4884   291  289    0 :    0    0 :      0      0      0      0
size-8192(DMA)         0      0   8192    0    0    2 :      0       0     0    0    0 :    0    0 :      0      0      0      0
size-8192              6      8   8192    6    8    2 :     22   21412   768  760    0 :    0    0 :      0      0      0      0
size-4096(DMA)         0      0   4096    0    0    1 :      0       0     0    0    0 :   60   30 :      0      0      0      0
size-4096            156    246   4096  156  246    1 :    463  279737 78616 78370    0 :   60   30 : 1469009 166296 1550045   6545
size-2048(DMA)         0      0   2048    0    0    1 :      0       0     0    0    0 :   60   30 :      0      0      0      0
size-2048            178    178   2048   89   89    1 :    420 1697552 21331 21242    0 :   60   30 : 5378643 101798 5411501  47494
size-1024(DMA)         0      0   1024    0    0    1 :      0       0     0    0    0 :  124   62 :      0      0      0      0
size-1024           1616   1616   1024  404  404    1 :   1684  191356  2505 2101    0 :  124   62 : 363118   9751 368754    207
size-512(DMA)          0      0    512    0    0    1 :      0       0     0    0    0 :  124   62 :      0      0      0      0
size-512             240    240    512   30   30    1 :    296   62964  2569 2539    0 :  124   62 : 467583   9140 473925    143
size-256(DMA)          0      0    264    0    0    1 :      0       0     0    0    0 :  124   62 :      0      0      0      0
size-256             178    240    264   16   16    1 :    420 2506573  1364 1348    0 :  124   62 : 70892164  48800 70928186  11367
size-128(DMA)          0      0    136    0    0    1 :      0       0     0    0    0 :  252  126 :      0      0      0      0
size-128            8246   8372    136  299  299    1 :   8428 2116636   845  546    0 :  252  126 : 21917394  19588 21924100   4385
size-64(DMA)           0      0     72    0    0    1 :      0       0     0    0    0 :  252  126 :      0      0      0      0
size-64             2055   5565     72  105  105    1 : 232193 3324750 23380 23275    0 :  252  126 : 3123436  64272 3152098  11128
size-32(DMA)           0      0     40    0    0    1 :      0       0     0    0    0 :  252  126 :      0      0      0      0
size-32             3136  19019     40  207  209    1 :  87633 6746224 13433 13224    0 :  252  126 : 160859646  72752 160891961  24599



> Sample output of slabtop is as follows:
> 
> Active / Total Objects (% used)    : 42403 / 63315 (67.0%)
> Active / Total Slabs (% used)      : 3461 / 3461 (100.0%)
> Active / Total Caches (% used)     : 60 / 97 (61.9%)
> Active / Total Size (% used)       : 10151.11K / 14245.87K (71.3%)
> Minimum / Average / Maximum Object : 0.02K / 0.22K / 128.00K
>                                                                                 
>   OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
>  14000   7390  52%    0.07K    280       50      1120K size-64
>  10528   5280  50%    0.26K    752       14      3008K dentry_cache
>   9660   8602  89%    0.12K    322       30      1288K pte_chain
>   8368   4913  58%    0.47K   1046        8      4184K ext3_inode_cache
>   3300   3143  95%    0.07K     66       50       264K vm_area_struct
>   3190   1089  34%    0.06K     55       58       220K buffer_head
>   3024   2924  96%    0.04K     36       84       144K size-32
>   2506   1982  79%    0.27K    179       14       716K radix_tree_node
>   1782   1750  98%    0.14K     66       27       264K filp
>    891    864  96%    0.14K     33       27       132K size-128
>    869    862  99%    0.33K     79       11       316K inode_cache
>    318    274  86%    0.07K      6       53        24K bio
>    305    256  83%    0.06K      5       61        20K biovec-4
>    288    281  97%    0.02K      2      144         8K biovec-1
>    266    256  96%    0.20K     14       19        56K biovec-16
>    260    256  98%    0.76K     52        5       208K biovec-64
> 
> I hope this tool will be of some use to all kernel developers.  Robert
> has made procps packages available here:
> 
> http://www.tech9.net/rml/procps/
> 
> All bug reports and feature requests are welcome.  Hopefully, slabtop
> will save the day.
> 
> Chris
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
