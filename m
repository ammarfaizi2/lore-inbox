Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132623AbRDQN0D>; Tue, 17 Apr 2001 09:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132625AbRDQNZ4>; Tue, 17 Apr 2001 09:25:56 -0400
Received: from scribe.cc.purdue.edu ([128.210.11.6]:17589 "EHLO
	scribe.cc.purdue.edu") by vger.kernel.org with ESMTP
	id <S132623AbRDQNZo>; Tue, 17 Apr 2001 09:25:44 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <15068.17426.410665.117723@oeuvre.acio.gov>
Date: Tue, 17 Apr 2001 08:24:34 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.4.3 Linux kernel crash: `Unable to handle kernel paging request at virtual address 189d4d44'
X-Mailer: VM 6.89 under 21.2  (beta46) "Urania" XEmacs Lucid
Reply-To: mcrogan@purdue.edu
From: mcrogan@purdue.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running the unpatched Linux-2.4.3, under Debian GNU/Linux.

I was simply running XEmacs, zsh, screen in a tty and then I started to
get many problems at the same time.  If I can provide more information,
please let me know.

Output of ver_linux:

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux localhost 2.4.3 #3 Wed Apr 11 01:01:12 EST 2001 i686 unknown
 
Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.9.5.0.37
util-linux             2.10f
modutils               2.3.11
e2fsprogs              1.18
pcmcia-cs              3.1.22
PPP                    2.3.11
isdn4k-utils           3.0beta2
Linux C Library        2.1.3
ldd: version 1.9.11
Procps                 2.0.6
Net-tools              1.54
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         lp tdfx cpia_usb cpia ibmcam videodev usbcore isofs parport_pc parport ide-floppy ide-cd busmouse agpgart cdrom floppy eepro100

Output of dmesg:

0000
CPU:    0
EIP:    0010:[<c0124482>]
EFLAGS: 00010886
eax: 55a57f4b   ebx: c144f188   ecx: e0df92c0   edx: c2075000
esi: 00000246   edi: 00000007   ebp: ccbcfd40   esp: ccbddf28
ds: 0018   es: 0018   ss: 0018
Process zsh (pid: 741, stackpage=ccbdd000)
Stack: c3b52a40 c79d4000 bfffda38 c0134ad9 0000002c 00000007 c3b52a40 ccbcfda0 
       c0134b8a c3b52a40 ccbdc000 c0134c42 ccbdc000 ccbddfb8 bfffda38 bfffda04 
       ccbddfac ccbddf98 ffffffe9 bfffda58 c0119f79 00000002 ccbddfac 00000000 
Call Trace: [<c0134ad9>] [<c0134b8a>] [<c0134c42>] [<c0119f79>] [<c010ae55>] [<c0106d5f>] 

Code: 8b 44 82 18 89 42 14 83 f8 ff 75 05 8b 02 89 43 08 56 9d 89 
Unable to handle kernel paging request at virtual address 189d4d44
 printing eip:
c0124482
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0124482>]
EFLAGS: 00010886
eax: 55a57f4b   ebx: c144f188   ecx: e0df92c0   edx: c2075000
esi: 00000246   edi: 00000007   ebp: ce25cba0   esp: cce11f28
ds: 0018   es: 0018   ss: 0018
Process zsh (pid: 723, stackpage=cce11000)
Stack: cad23260 cf67c000 bfffda38 c0134ad9 0000002c 00000007 cad23260 ce25cc00 
       c0134b8a cad23260 cce10000 c0134c42 cce10000 cce11fb8 bfffda38 bfffda04 
       cce11fac cce11f98 ffffffe9 bfffda58 c0119f79 00000002 cce11fac 00000000 
Call Trace: [<c0134ad9>] [<c0134b8a>] [<c0134c42>] [<c0119f79>] [<c010ae55>] [<c0106d5f>] 

Code: 8b 44 82 18 89 42 14 83 f8 ff 75 05 8b 02 89 43 08 56 9d 89 
Unable to handle kernel paging request at virtual address 189d4d44
 printing eip:
c0124482
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0124482>]
EFLAGS: 00010886
eax: 55a57f4b   ebx: c144f188   ecx: e0df92c0   edx: c2075000
esi: 00000246   edi: 00000007   ebp: ccf1c920   esp: cd6e3f28
ds: 0018   es: 0018   ss: 0018
Process zsh (pid: 651, stackpage=cd6e3000)
Stack: c1c1b0a0 c2e24000 bfffdb58 c0134ad9 0000002c 00000007 c1c1b0a0 ccf1c980 
       c0134b8a c1c1b0a0 cd6e2000 c0134c42 cd6e2000 cd6e3fb8 bfffdb58 bfffdb24 
       cd6e3fac cd6e3f98 ffffffe9 bfffdb78 c0119f79 00000002 cd6e3fac 00000000 
Call Trace: [<c0134ad9>] [<c0134b8a>] [<c0134c42>] [<c0119f79>] [<c010ae55>] [<c0106e7c>] [<c0106d5f>] 

Code: 8b 44 82 18 89 42 14 83 f8 ff 75 05 8b 02 89 43 08 56 9d 89 
Unable to handle kernel paging request at virtual address 189d4d44
 printing eip:
c0124482
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0124482>]
EFLAGS: 00010886
eax: 55a57f4b   ebx: c144f188   ecx: e0df92c0   edx: c2075000
esi: 00000246   edi: 00000007   ebp: c6e2af80   esp: cd917f28
ds: 0018   es: 0018   ss: 0018
Process zsh (pid: 633, stackpage=cd917000)
Stack: c5d39d60 c6752000 bfffdb58 c0134ad9 0000002c 00000007 c5d39d60 c7e0db00 
       c0134b8a c5d39d60 cd916000 c0134c42 cd916000 cd917fb8 bfffdb58 bfffdb24 
       cd917fac cd917f98 ffffffe9 bfffdb78 c0119f79 00000002 cd917fac 00000000 
Call Trace: [<c0134ad9>] [<c0134b8a>] [<c0134c42>] [<c0119f79>] [<c010ae55>] [<c0106e7c>] [<c0106d5f>] 

Code: 8b 44 82 18 89 42 14 83 f8 ff 75 05 8b 02 89 43 08 56 9d 89 
Unable to handle kernel paging request at virtual address 189d4d44
 printing eip:
c0124482
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0124482>]
EFLAGS: 00010886
eax: 55a57f4b   ebx: c144f188   ecx: e0df92c0   edx: c2075000
esi: 00000246   edi: 00000007   ebp: c7121780   esp: cdd7df28
ds: 0018   es: 0018   ss: 0018
Process zsh (pid: 597, stackpage=cdd7d000)
Stack: c72ccde0 cb507000 bfffdb58 c0134ad9 0000002c 00000007 c72ccde0 c71217e0 
       c0134b8a c72ccde0 cdd7c000 c0134c42 cdd7c000 cdd7dfb8 bfffdb58 bfffdb24 
       cdd7dfac cdd7df98 ffffffe9 bfffdb78 c0119f79 00000002 cdd7dfac 00000000 
Call Trace: [<c0134ad9>] [<c0134b8a>] [<c0134c42>] [<c0119f79>] [<c010ae55>] [<c0106e7c>] [<c0106d5f>] 

Code: 8b 44 82 18 89 42 14 83 f8 ff 75 05 8b 02 89 43 08 56 9d 89 
Unable to handle kernel paging request at virtual address 189d4d44
 printing eip:
c0124482
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0124482>]
EFLAGS: 00010886
eax: 55a57f4b   ebx: c144f188   ecx: e0df92c0   edx: c2075000
esi: 00000246   edi: 00000007   ebp: cdeb8a40   esp: cde39f28
ds: 0018   es: 0018   ss: 0018
Process zsh (pid: 591, stackpage=cde39000)
Stack: c7e7dda0 cb643000 bfffdb58 c0134ad9 0000002c 00000007 c7e7dda0 c7459bc0 
       c0134b8a c7e7dda0 cde38000 c0134c42 cde38000 cde39fb8 bfffdb58 bfffdb24 
       cde39fac cde39f98 ffffffe9 bfffdb78 c0119f79 00000002 cde39fac 00000000 
Call Trace: [<c0134ad9>] [<c0134b8a>] [<c0134c42>] [<c0119f79>] [<c010ae55>] [<c0106e7c>] [<c0106d5f>] 

Code: 8b 44 82 18 89 42 14 83 f8 ff 75 05 8b 02 89 43 08 56 9d 89 
Unable to handle kernel paging request at virtual address 189d4d44
 printing eip:
c0124482
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0124482>]
EFLAGS: 00010886
eax: 55a57f4b   ebx: c144f188   ecx: e0df92c0   edx: c2075000
esi: 00000246   edi: 00000007   ebp: cdeb84a0   esp: cdef5f28
ds: 0018   es: 0018   ss: 0018
Process zsh (pid: 585, stackpage=cdef5000)
Stack: c8bb5da0 c732e000 bfffdb58 c0134ad9 0000002c 00000007 c8bb5da0 c74592c0 
       c0134b8a c8bb5da0 cdef4000 c0134c42 cdef4000 cdef5fb8 bfffdb58 bfffdb24 
       cdef5fac cdef5f98 ffffffe9 bfffdb78 c0119f79 00000002 cdef5fac 00000000 
Call Trace: [<c0134ad9>] [<c0134b8a>] [<c0134c42>] [<c0119f79>] [<c010ae55>] [<c0106e7c>] [<c0106d5f>] 

Code: 8b 44 82 18 89 42 14 83 f8 ff 75 05 8b 02 89 43 08 56 9d 89 
Unable to handle kernel paging request at virtual address 189d4d44
 printing eip:
c0124482
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0124482>]
EFLAGS: 00010886
eax: 55a57f4b   ebx: c144f188   ecx: e0df92c0   edx: c2075000
esi: 00000246   edi: 00000007   ebp: ce6c6ba0   esp: cdfb1f28
ds: 0018   es: 0018   ss: 0018
Process zsh (pid: 579, stackpage=cdfb1000)
Stack: c78cf420 cdf99000 bfffdb58 c0134ad9 0000002c 00000007 c78cf420 cb79b0e0 
       c0134b8a c78cf420 cdfb0000 c0134c42 cdfb0000 cdfb1fb8 bfffdb58 bfffdb24 
       cdfb1fac cdfb1f98 ffffffe9 bfffdb78 c0119f79 00000002 cdfb1fac 00000000 
Call Trace: [<c0134ad9>] [<c0134b8a>] [<c0134c42>] [<c0119f79>] [<c010ae55>] [<c0106e7c>] [<c0106d5f>] 

Code: 8b 44 82 18 89 42 14 83 f8 ff 75 05 8b 02 89 43 08 56 9d 89 
Unable to handle kernel paging request at virtual address 189d4d44
 printing eip:
c0124482
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0124482>]
EFLAGS: 00010886
eax: 55a57f4b   ebx: c144f188   ecx: e0df92c0   edx: c2075000
esi: 00000246   edi: 00000007   ebp: ce6c6840   esp: ce06df28
ds: 0018   es: 0018   ss: 0018
Process zsh (pid: 573, stackpage=ce06d000)
Stack: c78cf7e0 c746e000 bfffdb58 c0134ad9 0000002c 00000007 c78cf7e0 ca401180 
       c0134b8a c78cf7e0 ce06c000 c0134c42 ce06c000 ce06dfb8 bfffdb58 bfffdb24 
       ce06dfac ce06df98 ffffffe9 bfffdb78 c0119f79 00000002 ce06dfac 00000000 
Call Trace: [<c0134ad9>] [<c0134b8a>] [<c0134c42>] [<c0119f79>] [<c010ae55>] [<c0106e7c>] [<c0106d5f>] 

Code: 8b 44 82 18 89 42 14 83 f8 ff 75 05 8b 02 89 43 08 56 9d 89 
Unable to handle kernel paging request at virtual address 189d4d44
 printing eip:
c0124482
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0124482>]
EFLAGS: 00010886
eax: 55a57f4b   ebx: c144f188   ecx: e0df92c0   edx: c2075000
esi: 00000246   edi: 00000007   ebp: ce6c62a0   esp: ce127f28
ds: 0018   es: 0018   ss: 0018
Process zsh (pid: 567, stackpage=ce127000)
Stack: c7a4ae00 c4f2d000 bfffdb58 c0134ad9 0000002c 00000007 c7a4ae00 cc315ce0 
       c0134b8a c7a4ae00 ce126000 c0134c42 ce126000 ce127fb8 bfffdb58 bfffdb24 
       ce127fac ce127f98 ffffffe9 bfffdb78 c0119f79 00000002 ce127fac 00000000 
Call Trace: [<c0134ad9>] [<c0134b8a>] [<c0134c42>] [<c0119f79>] [<c010ae55>] [<c0106e7c>] [<c0106d5f>] 

Code: 8b 44 82 18 89 42 14 83 f8 ff 75 05 8b 02 89 43 08 56 9d 89 

Excerpt from `nm vmlinux |sort':

c01201a4 T do_generic_file_read
c01206b0 t file_read_actor
c0120704 T generic_file_read
c0120784 t file_send_actor
c01207f8 T sys_sendfile
c01209e8 t nopage_sequential_readahead
c0120af8 T filemap_nopage
c0120ef8 T filemap_sync
c012110c T generic_file_mmap
c012118c t msync_interval
c0121228 T sys_msync
c0121310 t madvise_fixup_start
c01213f8 t madvise_fixup_end
c01214e8 t madvise_fixup_middle
c0121658 t madvise_behavior
c01216e8 t madvise_willneed
c012191c t madvise_dontneed
c0121964 t madvise_vma
c01219b8 T sys_madvise
c0121aa4 t mincore_page
c0121b58 t mincore_vma
c0121c5c T sys_mincore
c0121d60 T read_cache_page
c0121f08 T grab_cache_page
c0121fb4 T generic_file_write
c0122400 t change_protection
c0122400 t gcc2_compiled.
c0122568 t mprotect_fixup
c0122850 T sys_mprotect
c0122980 t gcc2_compiled.
c0122980 t mlock_fixup
c0122c58 t do_mlock
c0122d2c T sys_mlock
c0122dc4 T sys_munlock
c0122e28 t do_mlockall
c0122ea4 T sys_mlockall
c0122f24 T sys_munlockall
c0122f70 t gcc2_compiled.
c0122f70 t move_one_page
c0123028 t move_page_tables
c01230c0 T do_mremap
c0123478 T sys_mremap
c01234e0 T vmfree_area_pages
c01234e0 t gcc2_compiled.
c0123664 T get_vm_area
c0123718 T vfree
c0123780 T __vmalloc
c012399c T vread
c0123a20 T vmalloc_area_pages
c0123bc0 t gcc2_compiled.
c0123bc0 t kmem_cache_estimate
c0123c50 t kmem_slab_destroy
c0123cf4 T kmem_cache_create
c0124070 t __kmem_cache_shrink
c01240b8 T kmem_cache_shrink
c01240fc T kmem_cache_destroy
c01241e0 t kmem_cache_grow
c01243e8 T kmem_cache_alloc
c012443c T kmalloc
c01244c4 T kmem_cache_free
c0124570 T kfree
c0124624 T kmem_find_general_cachep
c0124654 T kmem_cache_reap
c0124840 t proc_getdata
c0124974 T slabinfo_read_proc
c01249bc T slabinfo_write_proc
c01249c4 t gcc2_compiled.
c01249d0 T age_page_up_nolock
c01249d0 t gcc2_compiled.
c01249fc T age_page_down_ageonly
c0124a08 T age_page_down_nolock
c0124a24 T age_page_up
c0124a50 T age_page_down
c0124a6c T deactivate_page_nolock
c0124ba8 T deactivate_page
c0124bb8 T activate_page_nolock
c0124d9c T activate_page
c0124dac T lru_cache_add
c0124e8c T __lru_cache_del
c0125044 T lru_cache_del
c012507c T recalculate_vm_stats
c0125090 t gcc2_compiled.
c0125090 t try_to_swap_out
c0125244 t swap_out_pmd
c0125338 t swap_out_vma
c012541c t swap_out_mm
c012547c t swap_out
c0125524 T reclaim_page
c0125920 T page_launder
c0126174 T refill_inactive_scan
c0126274 T free_shortage
c0126324 T inactive_shortage
c01263a0 t refill_inactive
c0126438 t do_try_to_free_pages
c01264b4 T kswapd
c01265a8 T wakeup_kswapd
c01265c4 T try_to_free_pages
c01265f0 T kreclaimd
c0126690 t gcc2_compiled.
c0126690 t rw_swap_page_base
c012683c T rw_swap_page
c01268f8 T rw_swap_page_nolock
c01269f0 t __free_pages_ok
c01269f0 t gcc2_compiled.
c0126cf8 t rmqueue
c0126f40 t __alloc_pages_limit
c0126fe8 T __alloc_pages
c01272b8 T __get_free_pages
c01272d8 T get_zeroed_page
c0127304 T __free_pages
c0127320 T free_pages
c0127348 T nr_free_pages
c012737c T nr_inactive_clean_pages
c01273b8 T nr_free_buffer_pages
c0127408 T show_free_areas_core
c0127500 T show_free_areas
c0127510 t gcc2_compiled.
c0127510 t swap_writepage
c0127524 T show_swap_cache_info
c012754c T add_to_swap_cache
c01275e4 T __delete_from_swap_cache
c0127660 T delete_from_swap_cache_nolock
c01276b8 T delete_from_swap_cache
c0127714 T free_page_and_swap_cache
c01277c0 T lookup_swap_cache
c0127920 T read_swap_cache_async
c01279c0 T __get_swap_page
c01279c0 t gcc2_compiled.
c0127bc0 T __swap_free
c0127cdc t unuse_vma
c0127eb0 t unuse_process
c0127ef8 t try_to_unuse
c0128030 T sys_swapoff
c0128260 T get_swaparea_info
c0128488 T is_swap_partition
c01284c0 T sys_swapon
c0128bc0 T si_swapinfo
c0128c64 T swap_duplicate
c0128d1c T swap_count
c0128d9c T get_swaphandle_info
c0128e54 T valid_swaphandles
c0128ed0 T alloc_pages_node
c0128ed0 t gcc2_compiled.
c0128ef0 t gcc2_compiled.
c0128ef0 t int_sqrt
c0128f24 t badness
c0128fdc t select_bad_process
c012901c T oom_kill
c0129080 T out_of_memory
c01290d0 t gcc2_compiled.
c01290d0 t shmem_swp_entry
c012914c t shmem_free_swp
c01291ac t shmem_truncate_part
c01291e0 t shmem_recalc_inode
c0129214 t shmem_truncate
c0129318 t shmem_delete_inode
c0129364 t shmem_writepage
c01294e8 T shmem_nopage
c01297d8 T shmem_get_inode
c0129930 t shmem_statfs
c0129984 T shmem_lock
c0129a9c t shmem_lookup
c0129ab8 t shmem_mknod
c0129b18 t shmem_mkdir
c0129b38 t shmem_create
c0129b58 t shmem_link
c0129bc4 t shmem_empty
c0129c14 t shmem_unlink
c0129c44 t shmem_rename
c0129c78 t shmem_mmap
c0129cd4 t shmem_parse_options
c0129e24 t shmem_read_super
c0129eec t shmem_remount_fs
c0129f6c t shmem_clear_swp
c0129fb4 t shmem_unuse_inode
c012a0d0 T shmem_unuse
c012a108 T shmem_file_setup
c012a204 T shmem_zero_setup
c012a250 T vfs_statfs
c012a250 t gcc2_compiled.
c012a294 T sys_statfs
c012a328 T sys_fstatfs
c012a3b0 T do_truncate
c012a410 T sys_truncate
c012a5a8 T sys_ftruncate
c012a69c T sys_truncate64
c012a828 T sys_ftruncate64
c012a928 T sys_utime
c012a9ec T sys_utimes
c012aac0 T sys_access
c012abe8 T sys_chdir
c012ad0c T sys_fchdir
c012ae08 T sys_chroot
c012af30 T sys_fchmod
c012afb4 T sys_chmod
c012b044 t chown_common
c012b15c T sys_chown
c012b1a4 T sys_lchown
c012b1ec T sys_fchown
c012b228 T filp_open
c012b284 T dentry_open
c012b3cc T get_unused_fd
c012b534 T sys_open
c012b5e8 T sys_creat
c012b600 T filp_close
c012b664 T sys_close
c012b6b8 T sys_vhangup
c012b6f0 T generic_read_dir
c012b6f0 t gcc2_compiled.
c012b6f8 T default_llseek
c012b770 T sys_lseek
c012b7e4 T sys_llseek
c012b8b0 T sys_read
c012b97c T sys_write
c012ba40 t do_readv_writev
c012bc70 T sys_readv
c012bcc4 T sys_writev
c012bd18 T sys_pread
c012bde8 T sys_pwrite
c012bec0 T get_device_list
c012bec0 t gcc2_compiled.
c012bf28 t get_chrfops
c012bff0 T register_chrdev
c012c074 T unregister_chrdev
c012c0d4 T chrdev_open
c012c120 T kdevname
c012c148 T cdevname
c012c184 t sock_no_open
c012c18c T init_special_inode
c012c250 T get_empty_filp
c012c250 t gcc2_compiled.
c012c34c T init_private_file
c012c3b8 T fput
c012c488 T fget
c012c4b0 T put_filp
c012c4e8 T file_move
c012c514 T file_moveto
c012c538 T fs_may_remount_ro
c012c590 T __wait_on_buffer
c012c590 t gcc2_compiled.
c012c61c t sync_buffers
c012c7cc T sync_dev
c012c7f4 T fsync_dev
c012c82c T sys_sync
c012c83c T file_fsync
c012c8b4 T sys_fsync
c012c944 T sys_fdatasync
c012c9d4 t __insert_into_lru_list
c012ca2c t __remove_from_lru_list
c012ca94 t __remove_from_free_list
c012cae8 t __remove_from_queues
c012cb1c t __insert_into_queues
c012cba0 t put_last_free
c012cc08 T get_hash_table
c012cc9c T get_hardblocksize
c012ccc0 T buffer_insert_inode_queue
c012ccf4 t __remove_inode_queue
c012cd0c T inode_has_buffers
c012cd20 T __invalidate_buffers
c012ce00 T set_blocksize
c012d018 t refill_freelist
c012d048 T init_buffer
c012d064 t end_buffer_io_async
c012d160 T set_buffer_async_io
c012d16c T fsync_inode_buffers
c012d29c T osync_inode_buffers
c012d300 T invalidate_inode_buffers
c012d330 T getblk
c012d42c T balance_dirty_state
c012d488 T balance_dirty
c012d4a4 T __mark_buffer_dirty
c012d4d0 T mark_buffer_dirty
c012d508 t __refile_buffer
c012d574 T refile_buffer
c012d584 T __brelse
c012d5a4 T __bforget
c012d604 T bread
c012d668 t get_unused_buffer_head
c012d6fc T set_bh_page
c012d73c t create_buffers
c012d8ec t unmap_buffer
c012d944 T block_flushpage
c012d9d0 t create_empty_buffers
c012da3c t unmap_underlying_metadata
c012da9c t __block_write_full_page
c012dc18 t __block_prepare_write
c012de4c t __block_commit_write
c012df14 T block_read_full_page
c012e138 T cont_prepare_write
c012e3d0 T block_prepare_write
c012e40c T generic_commit_write
c012e46c T block_truncate_page
c012e644 T block_write_full_page
c012e788 T generic_block_bmap
c012e7c4 t end_buffer_io_kiobuf
c012e81c t wait_kio
c012e8e4 T brw_kiovec
c012ec50 T brw_page
c012ecec T block_symlink
c012ee00 t grow_buffers
c012ef68 t sync_page_buffers
c012efc0 T try_to_free_buffers
c012f12c T show_buffers
c012f144 t flush_dirty_buffers
c012f208 T wakeup_bdflush
c012f234 t sync_old_buffers
c012f26c T block_sync_page
c012f288 T sys_bdflush
c012f330 T bdflush
c012f408 T kupdate
c012f4f0 t gcc2_compiled.
c012f4f0 t get_filesystem
c012f508 t put_filesystem
c012f520 t find_filesystem
c012f558 T register_filesystem
c012f5a4 T unregister_filesystem
c012f5e0 t fs_index
c012f658 t fs_name
c012f6c8 t fs_maxindex
c012f6e0 T sys_sysfs
c012f728 T get_filesystem_list
c012f784 T get_fs_type
c012f7e8 t add_vfsmnt
c012fa08 t move_vfsmnt
c012fb8c t remove_vfsmnt
c012fc18 t mangle
c012fcac T get_filesystem_info

$ cat .config

#
# Automatically generated by make menuconfig: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
# CONFIG_EXPERIMENTAL is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
CONFIG_MPENTIUMIII=y
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_TOSHIBA is not set
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
CONFIG_MATH_EMULATION=y
CONFIG_MTRR=y
# CONFIG_SMP is not set
# CONFIG_X86_UP_IOAPIC is not set

#
# General setup
#
CONFIG_NET=y
# CONFIG_VISWS is not set
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
# CONFIG_PM is not set
# CONFIG_APM is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play configuration
#
CONFIG_PNP=y
CONFIG_ISAPNP=m

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096
# CONFIG_BLK_DEV_INITRD is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID5=m
CONFIG_BLK_DEV_LVM=m

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
CONFIG_NETLINK=y
CONFIG_RTNETLINK=y
# CONFIG_NETLINK_DEV is not set
CONFIG_NETFILTER=y
CONFIG_NETFILTER_DEBUG=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_RTNETLINK=y
CONFIG_NETLINK=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_NAT=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_TOS=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_LARGE_TABLES=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
# CONFIG_NET_IPGRE_BROADCAST is not set
CONFIG_IP_MROUTE=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_COMPAT_IPCHAINS=m
CONFIG_IP_NF_NAT_NEEDED=y
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
CONFIG_IPX=m
# CONFIG_IPX_INTERN is not set
CONFIG_ATALK=m
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=y
CONFIG_NETLINK=y
CONFIG_RTNETLINK=y
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_CSZ=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_POLICE=y

#
# Telephony Support
#
CONFIG_PHONE=m
CONFIG_PHONE_IXJ=m

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDETAPE=m
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_IDEDMA_PCI is not set
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_IDEDMA_PCI_AUTO is not set
# CONFIG_BLK_DEV_IDEDMA is not set
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_AEC62XX_TUNING is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD7409 is not set
# CONFIG_AMD7409_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_PIIX_TUNING is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_BLK_DEV_OSB4 is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
# CONFIG_IDEDMA_AUTO is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y

#
# SCSI support
#
CONFIG_SCSI=m
CONFIG_BLK_DEV_SD=m
CONFIG_SD_EXTRA_DEVS=40
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_NCR53C8XX is not set
CONFIG_SCSI_SYM53C8XX=m
CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=4
CONFIG_SCSI_NCR53C8XX_MAX_TAGS=32
CONFIG_SCSI_NCR53C8XX_SYNC=20
# CONFIG_SCSI_NCR53C8XX_PROFILE is not set
# CONFIG_SCSI_NCR53C8XX_IOMAPPED is not set
# CONFIG_SCSI_NCR53C8XX_PQS_PDS is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set

#
# I2O device support
#
CONFIG_I2O=m
CONFIG_I2O_PCI=m
CONFIG_I2O_BLOCK=m
CONFIG_I2O_LAN=m
CONFIG_I2O_SCSI=m
CONFIG_I2O_PROC=m

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Appletalk devices
#
# CONFIG_APPLETALK is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
CONFIG_EQUALIZER=m
# CONFIG_TUN is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_CS89x0 is not set
# CONFIG_TULIP is not set
# CONFIG_DE4X5 is not set
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
CONFIG_EEPRO100=m
# CONFIG_EEPRO100_PM is not set
# CONFIG_LNE390 is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
# CONFIG_8139TOO is not set
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_HAMACHI is not set
# CONFIG_SK98LIN is not set
# CONFIG_FDDI is not set
CONFIG_PLIP=m
CONFIG_PPP=m
# CONFIG_PPP_MULTILINK is not set
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_SLIP=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
CONFIG_SLIP_MODE_SLIP6=y

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
CONFIG_IRDA=m
CONFIG_IRLAN=m
CONFIG_IRNET=m
CONFIG_IRCOMM=m
CONFIG_IRDA_ULTRA=y
CONFIG_IRDA_OPTIONS=y
CONFIG_IRDA_CACHE_LAST_LSAP=y
CONFIG_IRDA_FAST_RR=y
CONFIG_IRDA_DEBUG=y

#
# Infrared-port device drivers
#
CONFIG_IRTTY_SIR=m
CONFIG_IRPORT_SIR=m
CONFIG_NSC_FIR=m
CONFIG_WINBOND_FIR=m
CONFIG_TOSHIBA_FIR=m
CONFIG_DONGLE=y
CONFIG_ESI_DONGLE=m
CONFIG_ACTISYS_DONGLE=m
CONFIG_TEKRAM_DONGLE=m
CONFIG_GIRBIL_DONGLE=m
CONFIG_LITELINK_DONGLE=m
CONFIG_OLD_BELKIN_DONGLE=m

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Input core support
#
CONFIG_INPUT=m
CONFIG_INPUT_KEYBDEV=m
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
# CONFIG_SERIAL_CONSOLE is not set
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=2048
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_PHILIPSPAR=m
CONFIG_I2C_ELV=m
CONFIG_I2C_VELLEMAN=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ELEKTOR=m
CONFIG_I2C_CHARDEV=m

#
# Mice
#
CONFIG_BUSMOUSE=m
CONFIG_ATIXL_BUSMOUSE=m
CONFIG_LOGIBUSMOUSE=m
CONFIG_MS_BUSMOUSE=m
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_82C710_MOUSE=m
CONFIG_PC110_PAD=m

#
# Joysticks
#
CONFIG_JOYSTICK=y
CONFIG_INPUT_NS558=m
CONFIG_INPUT_LIGHTNING=m
CONFIG_INPUT_PCIGAME=m
CONFIG_INPUT_ANALOG=m
CONFIG_INPUT_A3D=m
CONFIG_INPUT_ADI=m
CONFIG_INPUT_COBRA=m
CONFIG_INPUT_GF2K=m
CONFIG_INPUT_GRIP=m
CONFIG_INPUT_INTERACT=m
CONFIG_INPUT_TMDC=m
CONFIG_INPUT_SIDEWINDER=m
CONFIG_INPUT_SERPORT=m
CONFIG_INPUT_WARRIOR=m
CONFIG_INPUT_MAGELLAN=m
CONFIG_INPUT_SPACEORB=m
CONFIG_INPUT_SPACEBALL=m
CONFIG_INPUT_IFORCE_232=m
CONFIG_INPUT_IFORCE_USB=m
CONFIG_INPUT_DB9=m
CONFIG_INPUT_GAMECON=m
CONFIG_INPUT_TURBOGRAFX=m
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_INTEL_RNG is not set
CONFIG_NVRAM=m
CONFIG_RTC=m
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=m
CONFIG_AGP_INTEL=y
CONFIG_AGP_I810=y
CONFIG_AGP_VIA=y
CONFIG_AGP_AMD=y
CONFIG_AGP_SIS=y
CONFIG_AGP_ALI=y
CONFIG_DRM=y
CONFIG_DRM_TDFX=m
CONFIG_DRM_GAMMA=m
# CONFIG_DRM_R128 is not set
CONFIG_DRM_RADEON=m
# CONFIG_DRM_I810 is not set
CONFIG_DRM_MGA=m

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=m

#
# Video For Linux
#
CONFIG_VIDEO_PROC_FS=y
CONFIG_I2C_PARPORT=m
CONFIG_VIDEO_BT848=m
CONFIG_VIDEO_PMS=m
CONFIG_VIDEO_BWQCAM=m
CONFIG_VIDEO_CPIA=m
CONFIG_VIDEO_CPIA_PP=m
CONFIG_VIDEO_CPIA_USB=m
CONFIG_VIDEO_SAA5249=m
CONFIG_TUNER_3036=m
CONFIG_VIDEO_ZORAN=m
CONFIG_VIDEO_BUZ=m
CONFIG_VIDEO_ZR36120=m

#
# Radio Adapters
#
# CONFIG_RADIO_CADET is not set
# CONFIG_RADIO_RTRACK is not set
# CONFIG_RADIO_RTRACK2 is not set
# CONFIG_RADIO_AZTECH is not set
# CONFIG_RADIO_GEMTEK is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_MAESTRO is not set
# CONFIG_RADIO_MIROPCM20 is not set
# CONFIG_RADIO_SF16FMI is not set
# CONFIG_RADIO_TERRATEC is not set
# CONFIG_RADIO_TRUST is not set
# CONFIG_RADIO_TYPHOON is not set
# CONFIG_RADIO_ZOLTRIX is not set

#
# File systems
#
CONFIG_QUOTA=y
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y
# CONFIG_REISERFS_FS is not set
# CONFIG_REISERFS_CHECK is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_UMSDOS_FS=m
CONFIG_VFAT_FS=m
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_RAMFS=m
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_MINIX_FS=m
CONFIG_NTFS_FS=m
# CONFIG_NTFS_RW is not set
CONFIG_HPFS_FS=m
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
CONFIG_ROMFS_FS=m
CONFIG_EXT2_FS=y
CONFIG_SYSV_FS=m
# CONFIG_SYSV_FS_WRITE is not set
CONFIG_UDF_FS=m
# CONFIG_UDF_RW is not set
CONFIG_UFS_FS=m
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
CONFIG_NCP_FS=m
CONFIG_NCPFS_PACKET_SIGNING=y
CONFIG_NCPFS_IOCTL_LOCKING=y
CONFIG_NCPFS_STRONG=y
CONFIG_NCPFS_NFS_NS=y
CONFIG_NCPFS_OS2_NS=y
CONFIG_NCPFS_SMALLDOS=y
CONFIG_NCPFS_NLS=y
CONFIG_NCPFS_EXTRAS=y

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
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
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_UTF8 is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y

#
# Sound
#
CONFIG_SOUND=m
# CONFIG_SOUND_CMPCI is not set
CONFIG_SOUND_EMU10K1=m
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
CONFIG_SOUND_ES1371=m
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_ICH is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
CONFIG_SOUND_OSS=m
CONFIG_SOUND_TRACEINIT=y
CONFIG_SOUND_DMAP=y
# CONFIG_SOUND_SGALAXY is not set
# CONFIG_SOUND_ADLIB is not set
# CONFIG_SOUND_ACI_MIXER is not set
# CONFIG_SOUND_CS4232 is not set
# CONFIG_SOUND_SSCAPE is not set
# CONFIG_SOUND_GUS is not set
CONFIG_SOUND_VMIDI=m
# CONFIG_SOUND_TRIX is not set
# CONFIG_SOUND_MSS is not set
# CONFIG_SOUND_MPU401 is not set
# CONFIG_SOUND_NM256 is not set
# CONFIG_SOUND_MAD16 is not set
# CONFIG_SOUND_PAS is not set
# CONFIG_PAS_JOYSTICK is not set
# CONFIG_SOUND_PSS is not set
CONFIG_SOUND_SB=m
CONFIG_SOUND_AWE32_SYNTH=m
# CONFIG_SOUND_WAVEFRONT is not set
# CONFIG_SOUND_MAUI is not set
# CONFIG_SOUND_YM3812 is not set
# CONFIG_SOUND_OPL3SA1 is not set
# CONFIG_SOUND_OPL3SA2 is not set
# CONFIG_SOUND_YMFPCI is not set
# CONFIG_SOUND_YMFPCI_LEGACY is not set
# CONFIG_SOUND_UART6850 is not set
# CONFIG_SOUND_AEDSP16 is not set
# CONFIG_SOUND_TVMIXER is not set

#
# USB support
#
CONFIG_USB=m
CONFIG_USB_DEBUG=y
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_UHCI is not set
CONFIG_USB_UHCI_ALT=m
CONFIG_USB_OHCI=m
CONFIG_USB_AUDIO=m
# CONFIG_USB_BLUETOOTH is not set
CONFIG_USB_STORAGE=m
CONFIG_USB_STORAGE_DEBUG=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_HID=m
CONFIG_USB_KBD=m
CONFIG_USB_MOUSE=m
CONFIG_USB_WACOM=m
CONFIG_USB_DC2XX=m
# CONFIG_USB_MDC800 is not set
CONFIG_USB_SCANNER=m
# CONFIG_USB_MICROTEK is not set
CONFIG_USB_IBMCAM=m
CONFIG_USB_OV511=m
# CONFIG_USB_DSBR is not set
CONFIG_USB_DABUSB=m
# CONFIG_USB_PLUSB is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_NET1080 is not set
CONFIG_USB_USS720=m

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_DEBUG=y
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
CONFIG_USB_SERIAL_VISOR=m
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_RIO500 is not set

#
# Kernel hacking
#
CONFIG_MAGIC_SYSRQ=y

For what it's worth, I am running $ZSH_VERSION 3.1.9-dev-6:

Package: zsh
Status: install ok installed
Priority: optional
Section: shells
Installed-Size: 2575
Maintainer: Clint Adams <schizo@debian.org>
Version: 3.1.9.dev6-7
Depends: libc6 (>= 2.1.2), libncurses5
Suggests: zsh-doc
Conffiles:
 /etc/zlogin 936fe20fd7fadf2cc0935f400fc0ef38
 /etc/zlogout d466a6b6947043008d171d33614ba259
 /etc/zprofile 9f192e65a60d7db5870e30ad1c49299c
 /etc/zshenv 9bd6102791ae447d07b25296fbfa2f4d
 /etc/zshrc df2eb8210493f8ea3c967ec80cfbd23b
Description: A shell with lots of features.
 Zsh is a UNIX command interpreter (shell) usable as an
 interactive login shell and as a shell script command
 processor. Of the standard shells, zsh most closely resembles
 ksh but includes many enhancements. Zsh has command-line editing,
 built-in spelling correction, programmable command completion,
 shell functions (with autoloading), a history mechanism, and a
 host of other features.



