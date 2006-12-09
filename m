Return-Path: <linux-kernel-owner+w=401wt.eu-S1759156AbWLIK5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759156AbWLIK5b (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 05:57:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935330AbWLIK5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 05:57:31 -0500
Received: from hempcity.net ([81.171.100.190]:35611 "EHLO hempcity.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759156AbWLIK5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 05:57:30 -0500
Message-ID: <16096.62.194.65.8.1165661845.squirrel@webmail.coolzero.info>
In-Reply-To: <20061209105436.GB10261@atrey.karlin.mff.cuni.cz>
References: <13634.62.194.65.8.1165659510.squirrel@webmail.coolzero.info>
    <20061209105436.GB10261@atrey.karlin.mff.cuni.cz>
Date: Sat, 9 Dec 2006 11:57:25 +0100 (CET)
Subject: Re: Ext3 Errors...
From: "Jim van Wel" <jim@coolzero.info>
To: "Jan Kara" <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org
Reply-To: jim@coolzero.info
User-Agent: SquirrelMail/1.4.8-2.el4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

Here is the output of /proc/slabinfo

slabinfo - version: 2.1
# name            <active_objs> <num_objs> <objsize> <objperslab>
<pagesperslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata
<active_slabs> <num_slabs> <sharedavail>
ip_conntrack_expect      0      0    136   28    1 : tunables  120   60   
8 : slabdata      0      0      0
ip_conntrack         641   1040    304   13    1 : tunables   54   27    8
: slabdata     80     80      0
fib6_nodes             5     59     64   59    1 : tunables  120   60    8
: slabdata      1      1      0
ip6_dst_cache          4     12    320   12    1 : tunables   54   27    8
: slabdata      1      1      0
ndisc_cache            1     12    320   12    1 : tunables   54   27    8
: slabdata      1      1      0
RAWv6                  5      7   1088    7    2 : tunables   24   12    8
: slabdata      1      1      0
UDPv6                  1      7   1088    7    2 : tunables   24   12    8
: slabdata      1      1      0
tw_sock_TCPv6         39    100    192   20    1 : tunables  120   60    8
: slabdata      5      5      0
request_sock_TCPv6      0      0    192   20    1 : tunables  120   60   
8 : slabdata      0      0      0
TCPv6                 12     12   1920    2    1 : tunables   24   12    8
: slabdata      6      6      0
rpc_buffers            8      8   2048    2    1 : tunables   24   12    8
: slabdata      4      4      0
rpc_tasks              8     10    384   10    1 : tunables   54   27    8
: slabdata      1      1      0
rpc_inode_cache        6      8    960    4    1 : tunables   54   27    8
: slabdata      2      2      0
ip_fib_alias          12     59     64   59    1 : tunables  120   60    8
: slabdata      1      1      0
ip_fib_hash           11     59     64   59    1 : tunables  120   60    8
: slabdata      1      1      0
jbd_1k                 0      0   1024    4    1 : tunables   54   27    8
: slabdata      0      0      0
dm_tio                 0      0     24  144    1 : tunables  120   60    8
: slabdata      0      0      0
dm_io                  0      0     40   92    1 : tunables  120   60    8
: slabdata      0      0      0
uhci_urb_priv          0      0     56   67    1 : tunables  120   60    8
: slabdata      0      0      0
jbd_4k                 5     10   4096    1    1 : tunables   24   12    8
: slabdata      5     10      0
ext3_inode_cache   22447  22696    968    4    1 : tunables   54   27    8
: slabdata   5674   5674      0
ext3_xattr             0      0     88   44    1 : tunables  120   60    8
: slabdata      0      0      0
journal_handle        24    144     24  144    1 : tunables  120   60    8
: slabdata      1      1      0
journal_head         740   1280     96   40    1 : tunables  120   60    8
: slabdata     27     32    480
revoke_table           4    202     16  202    1 : tunables  120   60    8
: slabdata      1      1      0
revoke_record         16    112     32  112    1 : tunables  120   60    8
: slabdata      1      1      0
UNIX                  60     92    896    4    1 : tunables   54   27    8
: slabdata     23     23      0
flow_cache             0      0    128   30    1 : tunables  120   60    8
: slabdata      0      0      0
msi_cache              5     59     64   59    1 : tunables  120   60    8
: slabdata      1      1      0
cfq_ioc_pool           0      0    160   24    1 : tunables  120   60    8
: slabdata      0      0      0
cfq_pool               0      0    160   24    1 : tunables  120   60    8
: slabdata      0      0      0
mqueue_inode_cache      1      7   1088    7    2 : tunables   24   12   
8 : slabdata      1      1      0
isofs_inode_cache      0      0    768    5    1 : tunables   54   27    8
: slabdata      0      0      0
hugetlbfs_inode_cache      1      5    752    5    1 : tunables   54   27 
  8 : slabdata      1      1      0
ext2_inode_cache       0      0    920    4    1 : tunables   54   27    8
: slabdata      0      0      0
ext2_xattr             0      0     88   44    1 : tunables  120   60    8
: slabdata      0      0      0
dnotify_cache          1     92     40   92    1 : tunables  120   60    8
: slabdata      1      1      0
dquot                  0      0    256   15    1 : tunables  120   60    8
: slabdata      0      0      0
eventpoll_pwq          1     53     72   53    1 : tunables  120   60    8
: slabdata      1      1      0
eventpoll_epi          1     20    192   20    1 : tunables  120   60    8
: slabdata      1      1      0
inotify_event_cache      0      0     40   92    1 : tunables  120   60   
8 : slabdata      0      0      0
inotify_watch_cache      0      0     72   53    1 : tunables  120   60   
8 : slabdata      0      0      0
kioctx                 0      0    384   10    1 : tunables   54   27    8
: slabdata      0      0      0
kiocb                  0      0    256   15    1 : tunables  120   60    8
: slabdata      0      0      0
fasync_cache           0      0     24  144    1 : tunables  120   60    8
: slabdata      0      0      0
shmem_inode_cache    220    224    960    4    1 : tunables   54   27    8
: slabdata     56     56      0
posix_timers_cache      0      0    152   25    1 : tunables  120   60   
8 : slabdata      0      0      0
uid_cache             19     60    128   30    1 : tunables  120   60    8
: slabdata      2      2      0
ip_mrt_cache           0      0    128   30    1 : tunables  120   60    8
: slabdata      0      0      0
tcp_bind_bucket       25    112     32  112    1 : tunables  120   60    8
: slabdata      1      1      0
inet_peer_cache        8     59     64   59    1 : tunables  120   60    8
: slabdata      1      1      0
secpath_cache          0      0     64   59    1 : tunables  120   60    8
: slabdata      0      0      0
xfrm_dst_cache         0      0    384   10    1 : tunables   54   27    8
: slabdata      0      0      0
ip_dst_cache        1344   1344    320   12    1 : tunables   54   27    8
: slabdata    112    112      0
arp_cache              2     15    256   15    1 : tunables  120   60    8
: slabdata      1      1      0
RAW                    3      4    896    4    1 : tunables   54   27    8
: slabdata      1      1      0
UDP                   10     16    896    4    1 : tunables   54   27    8
: slabdata      4      4      0
tw_sock_TCP            4     20    192   20    1 : tunables  120   60    8
: slabdata      1      1      0
request_sock_TCP      16     30    128   30    1 : tunables  120   60    8
: slabdata      1      1      0
TCP                   18     18   1792    2    1 : tunables   24   12    8
: slabdata      9      9      0
blkdev_ioc            57    134     56   67    1 : tunables  120   60    8
: slabdata      2      2      0
blkdev_queue          21     24   1672    4    2 : tunables   24   12    8
: slabdata      6      6      0
blkdev_requests       45    182    280   14    1 : tunables   54   27    8
: slabdata     13     13      0
biovec-256             7      7   4096    1    1 : tunables   24   12    8
: slabdata      7      7      0
biovec-128             7      8   2048    2    1 : tunables   24   12    8
: slabdata      4      4      0
biovec-64              7      8   1024    4    1 : tunables   54   27    8
: slabdata      2      2      0
biovec-16              7     15    256   15    1 : tunables  120   60    8
: slabdata      1      1      0
biovec-4               7     59     64   59    1 : tunables  120   60    8
: slabdata      1      1      0
biovec-1             207    808     16  202    1 : tunables  120   60    8
: slabdata      4      4    144
bio                  397   1440    128   30    1 : tunables  120   60    8
: slabdata     48     48     48
sock_inode_cache     136    160    832    4    1 : tunables   54   27    8
: slabdata     40     40      0
skbuff_fclone_cache     99    161    512    7    1 : tunables   54   27   
8 : slabdata     23     23      0
skbuff_head_cache    150    150    256   15    1 : tunables  120   60    8
: slabdata     10     10      0
file_lock_cache       61     80    192   20    1 : tunables  120   60    8
: slabdata      4      4      0
Acpi-Operand        1946   2006     64   59    1 : tunables  120   60    8
: slabdata     34     34      0
Acpi-ParseExt          0      0     64   59    1 : tunables  120   60    8
: slabdata      0      0      0
Acpi-Parse             0      0     40   92    1 : tunables  120   60    8
: slabdata      0      0      0
Acpi-State             0      0     80   48    1 : tunables  120   60    8
: slabdata      0      0      0
Acpi-Namespace       955   1008     32  112    1 : tunables  120   60    8
: slabdata      9      9      0
proc_inode_cache     406    485    752    5    1 : tunables   54   27    8
: slabdata     97     97      0
sigqueue              24     24    160   24    1 : tunables  120   60    8
: slabdata      1      1      0
radix_tree_node     8034   8106    536    7    1 : tunables   54   27    8
: slabdata   1158   1158    108
bdev_cache            27     32    960    4    1 : tunables   54   27    8
: slabdata      8      8      0
sysfs_dir_cache     3219   3264     80   48    1 : tunables  120   60    8
: slabdata     68     68      0
mnt_cache             28     30    256   15    1 : tunables  120   60    8
: slabdata      2      2      0
inode_cache          776    905    720    5    1 : tunables   54   27    8
: slabdata    181    181      0
dentry_cache       25160  25160    224   17    1 : tunables  120   60    8
: slabdata   1480   1480      0
filp                1079   1668    320   12    1 : tunables   54   27    8
: slabdata    139    139     47
names_cache            5      5   4096    1    1 : tunables   24   12    8
: slabdata      5      5      0
avc_node              12     53     72   53    1 : tunables  120   60    8
: slabdata      1      1      0
selinux_inode_security   1250   1280     96   40    1 : tunables  120   60
   8 : slabdata     32     32      0
key_jar               22     60    192   20    1 : tunables  120   60    8
: slabdata      3      3      0
idr_layer_cache       64     70    528    7    1 : tunables   54   27    8
: slabdata     10     10      0
buffer_head        56406  95386    104   37    1 : tunables  120   60    8
: slabdata   2578   2578    480
mm_struct             85    104    960    4    1 : tunables   54   27    8
: slabdata     26     26      0
vm_area_struct      8170  10098    176   22    1 : tunables  120   60    8
: slabdata    459    459    354
fs_cache              71    180    128   30    1 : tunables  120   60    8
: slabdata      6      6      0
files_cache           86    121    704   11    2 : tunables   54   27    8
: slabdata     11     11      0
signal_cache         116    140    768    5    1 : tunables   54   27    8
: slabdata     28     28      0
sighand_cache        110    126   2112    3    2 : tunables   24   12    8
: slabdata     42     42      0
task_struct          130    136   1840    2    1 : tunables   24   12    8
: slabdata     68     68      0
anon_vma             954   1196     40   92    1 : tunables  120   60    8
: slabdata     13     13      0
pid                  118    236     64   59    1 : tunables  120   60    8
: slabdata      4      4      0
shared_policy_node      0      0     48   77    1 : tunables  120   60   
8 : slabdata      0      0      0
numa_policy            7    144     24  144    1 : tunables  120   60    8
: slabdata      1      1      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0
: slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    0
: slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0
: slabdata      0      0      0
size-65536             1      1  65536    1   16 : tunables    8    4    0
: slabdata      1      1      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0
: slabdata      0      0      0
size-32768             1      1  32768    1    8 : tunables    8    4    0
: slabdata      1      1      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0
: slabdata      0      0      0
size-16384             8     10  16384    1    4 : tunables    8    4    0
: slabdata      8     10      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0
: slabdata      0      0      0
size-8192             28     28   8192    1    2 : tunables    8    4    0
: slabdata     28     28      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    8
: slabdata      0      0      0
size-4096            108    108   4096    1    1 : tunables   24   12    8
: slabdata    108    108      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    8
: slabdata      0      0      0
size-2048            288    288   2048    2    1 : tunables   24   12    8
: slabdata    144    144      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    8
: slabdata      0      0      0
size-1024            341    400   1024    4    1 : tunables   54   27    8
: slabdata    100    100     27
size-512(DMA)          0      0    512    8    1 : tunables   54   27    8
: slabdata      0      0      0
size-512             522    536    512    8    1 : tunables   54   27    8
: slabdata     67     67      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60    8
: slabdata      0      0      0
size-256              76    105    256   15    1 : tunables  120   60    8
: slabdata      7      7      0
size-192(DMA)          0      0    192   20    1 : tunables  120   60    8
: slabdata      0      0      0
size-192            1057   1120    192   20    1 : tunables  120   60    8
: slabdata     56     56      0
size-128(DMA)          0      0    128   30    1 : tunables  120   60    8
: slabdata      0      0      0
size-64(DMA)           0      0     64   59    1 : tunables  120   60    8
: slabdata      0      0      0
size-32(DMA)           0      0     32  112    1 : tunables  120   60    8
: slabdata      0      0      0
size-32             1969   2128     32  112    1 : tunables  120   60    8
: slabdata     19     19      0
size-128            1192   2010    128   30    1 : tunables  120   60    8
: slabdata     67     67     30
size-64            14943  15222     64   59    1 : tunables  120   60    8
: slabdata    258    258      0
kmem_cache           133    135    704    5    1 : tunables   54   27    8
: slabdata     27     27      0

Greetings,

Jim van Wel.

>   Hi,
>
>> I have something really strange while running kernel 2.6.19.
>>
>> See the following lines:
>>
>> Dec  5 23:50:49 kernel: do_get_write_access: OOM for frozen_buffer
>> Dec  5 23:50:49 kernel: ext3_free_blocks_sb: aborting transaction: Out
>> of
>> memory in __ext3_journal_get_undo_access
>> Dec  5 23:50:49 kernel: EXT3-fs error (device md1) in
>> ext3_free_blocks_sb:
>> Out of memory
>> Dec  5 23:50:49 kernel: EXT3-fs error (device md1) in
>> ext3_reserve_inode_write: Readonly filesystem
>> Dec  5 23:50:50 kernel: EXT3-fs error (device md1) in ext3_truncate: Out
>> of memory
>> Dec  5 23:50:51 kernel: EXT3-fs error (device md1) in
>> ext3_reserve_inode_write: Readonly filesystem
>> Dec  5 23:50:51 kernel: EXT3-fs error (device md1) in ext3_orphan_del:
>> Readonly filesystem
>> Dec  5 23:50:51 kernel: EXT3-fs error (device md1) in
>> ext3_reserve_inode_write: Readonly filesystem
>> Dec  5 23:50:51 kernel: EXT3-fs error (device md1) in ext3_delete_inode:
>> Out of memory
>>
>> And three days later the same:
>>
>> Dec  8 08:24:29 kernel: do_get_write_access: OOM for frozen_buffer
>> Dec  8 08:24:29 kernel: ext3_reserve_inode_write: aborting transaction:
>> Out of memory in __ext3_journal_get_write_access
>> Dec  8 08:24:29 kernel: EXT3-fs error (device md1) in
>> ext3_reserve_inode_write: Out of memory
>> Dec  8 08:24:32 kernel: EXT3-fs error (device md1) in ext3_dirty_inode:
>> Out of memory
>> Dec  8 08:24:32 kernel: EXT3-fs error (device md1) in ext3_new_blocks:
>> Readonly filesystem
>> Dec  8 08:24:32 kernel: EXT3-fs error (device md1) in
>> ext3_reserve_inode_write: Readonly filesystem
>> Dec  8 08:24:32 kernel: EXT3-fs error (device md1) in ext3_dirty_inode:
>> Out of memory
>> Dec  8 08:24:32 kernel: EXT3-fs error (device md1) in
>> ext3_prepare_write:
>> Out of memory
>>
>> Now the funny thing is, with kernel 2.6.18.3 I did not had these errors.
>> Could it be my memory that is just going nuts, or something else? I have
>> seen some other topics about the EXT3 corruption problems. Maybe this is
>> also the same thing?
>   Probably some error on the kernel's side. Maybe somebody (e.g. my new
> code in jbd commit) forgets to release some buffers? What does your
> /proc/slabinfo look like? Thanks for report.
>
> 								Honza
>

