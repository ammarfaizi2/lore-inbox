Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbWHCH5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbWHCH5L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 03:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWHCH5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 03:57:11 -0400
Received: from thunk.org ([69.25.196.29]:56472 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932391AbWHCH5J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 03:57:09 -0400
Date: Thu, 3 Aug 2006 03:57:04 -0400
From: Theodore Tso <tytso@mit.edu>
To: linux-kernel@vger.kernel.org
Subject: [PATCH -rt DO NOT APPLY] Fix for tg3 networking lockup
Message-ID: <20060803075704.GC27835@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


I'm sending this on mostly because it was a bit of a pain to track down,
and hopefully it will save time if anyone else hits this while playing
with the -rt kernel.  It is NOT the right way to fix things, so please
don't even think of applying this patch (unless you need it, in your own
local tree :-).

One of these days when we have time to breath we'll look into fixing
this the right way, if someone doesn't beat us to it first.  :-)

						- Ted


--ReaqsoxgOBHFXBhH
Content-Type: image/gif
Content-Disposition: attachment; filename="paper-bag.gif"
Content-Transfer-Encoding: base64

R0lGODlhQwBuAMIHADAwMIaGhl9fX7CwsNvb2wAAAP7+/v///yH+FUNyZWF0ZWQgd2l0aCBU
aGUgR0lNUAAsAAAAAEMAbgAAA/54utz+DxRIq70Yh5m7/0dRCAZongxRAEdAoPAnFG9bxxgQ
ZEYAADMBQ3DDWX4/wSAQWK4Ekp/rUGoQjRjDgDroeqtUi4GDvexiA1b5QlqAxSn1unI+LDHX
BUE+hwgVLnUUSHp8fQ5nAwSLFwVNVXuHFEIGQlsZBGeRkg91PR6XUJwPfzACgqOAOAKlqQqt
FotFCjquQ7MHKo4LIiKoNLYLSlYiISUqVQWXCsDBdq0qarU+CwNkIbijTAzFzCUBrQBgzcGb
uc0bCtZDy+TBciqs3a9/KtzZnAZ8PisOT7u88HEyRKESgFnKnFEh+MGdLYYeHKbSF0NiKogd
ACyzRf4RhsV8sEBc48iH0RsLIx+CUZTmJIWUrpoI24KxwRiFgC4REAIuwzqcMm0Yy0AN6MY0
GUPG3Hgw48ZgQV+hqnAKZ4unAh3UMopCFM5hJ+zhnGDAAAEvTM62GJELoVUmXmas6DLjILgN
IiR8hLqigMsFQAL3s3puxA86I2boU3rRFxS/EHRtODPD2QYiTx43BZw3Stu1T+f4YMVyQBBW
UX7k5bdD1otMXrFoieKl9k4RrFADQU3Dtetvm2PUdXG2tpdFcpPkFrFIkW9ZdlZoPGHtYPHj
ro/T1Zu3+HPfJWYDEVna+HPzzbuc/c6eQHjIHU4ZV99+vnrn7dmv7eDjOv79/NmxBCCALdTE
zXwDJqigbyHgQYRtC0aY4AFbVUBDE/9JqGF+Bppm34YgPkdhVspAGOKJsvTAmB0HIcjIAGah
mF2CK5IGoSJjkCAjdNYBOBUv5jkXAhO9yTgbTTF+92MuLZoIBDU7ujcZhfg9x9gSWN63yG5t
MZhkewowaM0e7fXwF1zaybLCd1oklB+FfjFoWJlLaoTeWTRkqKabz5Wg15cv4AVodi71Z5tz
hn4XHTDghcDcoHAOuoiZDsh3p4dVurboFik6ChmbyLQXwEl7XHqWEnpCpwunJeBGBZg99jkV
OB82h2F+fibkaGtvxgreqFZgaOKpqYoogjVsDf44InuUMmBnltihOaBZvUwwYY+dnCRferZZ
OmEvnCrb1E5IqDbSGHkpwaC3BOLGXJew9tUZErDE81i6vGHHrKPqvEsgFLnlppohG+ymWy8S
DPubo+69gOxrYEpnbmLAMnDZvAFDoS8u8wjzbgq/lQvXKxXsxBt3z6aYG5G4nUIrXo7cRVyK
ENUUWi6G4odutTz33DOMKcLUEQQw+rHxC+gCzaxk8DIi0R0UVKyVd9Ax3JZZWDdcg7+aBlfN
kiRDkPKk6AoxoS5aMzJdAz1NQvSDOru64KLwYlPpzWFChGaVyUa4VtpisS3Q0FYo3LSCTbfZ
Cd4sGn10lLNFIFBRd78/HuVPDew1HinCRgmeOfcMgjcrVHs+aTpTiw6BI5bLeAArD+yFuj+t
u16VPyj9VaKApr8Au03wQdB25tf1zsjt3IAdJkx58m76finA5E9KzWcaJfQBYaBL5nd6rjhn
HaggyO7WQ34NW/yRQ375O5KhQlaxk0G+8ZPKLz1KHKxPv1gdy9BX996bQP9AgDYA7mgMEsCC
/oxnNSOsr1ghghPjROIf9oXoewqsXu021KAyHKtWUbrfCR6osBCJkAEJAAA7

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="tg3-timer.patch"

Fix for tg3 networking lockup (LTC BZ# 25487)

The tg3 networking card is a finicky beast, and needs to be tickled
every tenth of a second or so or it will go deaf and dumb until it is
reset via "ifdown eth0; ifup eth0".

The problem comes if a workload consumes enough CPU power so that
tg3_timer() doesn't run frequently enough.  Unfortunately, the
softirq_timer doesn't run at a sufficiently high priority to guarantee
this, and boosting softirq_timer to prio 90 or so causes the customer
benchmark to fail due to a decrease in determinism due to running all
timers at high priority.

The right fix is to change the timer code to dynamically change
priorities, but this is a non-trivial fix.  This is a quick hack
driven by code freeze deadlines.  :-{

What we do is hack in a special case hook into kernel/clockevents.c to
enforce tg3_timer getting called approximately every 0.128 seconds
(assuming HZ=250).  This appears to be sufficient to stop the
networking hardware from going insane.

Brown-Paper-Bag-By:  "Theodore Ts'o" <tytso@mit.edu>


Index: linux-rtj12.7/drivers/net/tg3.c
===================================================================
--- linux-rtj12.7.orig/drivers/net/tg3.c	2006-08-02 10:11:09.000000000 -0400
+++ linux-rtj12.7/drivers/net/tg3.c	2006-08-03 02:17:41.000000000 -0400
@@ -342,6 +342,36 @@
 	{ "interrupt test (offline)" },
 };
 
+/*
+ * TG3 timer section
+ *
+ * HACK HACK HACK --- we need to make sure the timer runs at a high
+ * priority, but unfortunately there's no good way to do this given
+ * the current timer infrastructure.  So we kludge it, by hacking the
+ * clockevents code.  I wish there were a better a way, but changing
+ * all of the timer infrastructure to work like hrtimers is far too
+ * invasive, and the hrtimer infrastructure assumes that priority
+ * boosting only happens to in response to a process running at a
+ * particular priority depending on an hrtimer, so in order to use
+ * hrtimers I would have needed to create a kernel thread and then
+ * export all of the hrtimer functions.  This is ugly as sin, but it
+ * involves the smallest possible changes for ease of auditing. ---
+ * [tytso:20060803.0217EDT]
+ */
+
+extern void (*tg3_hack_hook)(void); /* defined in kernel/clockevents.c */
+static void tg3_timer(unsigned long __opaque); /* defined below */
+static LIST_HEAD(tg3_timer_list); /* list of all active tg3 interfaces */
+
+static void tg3_run_timers(void)
+{
+	struct tg3 *tp;
+
+	list_for_each_entry(tp, &tg3_timer_list, timer_hack_list) {
+		tg3_timer((unsigned long) tp);
+	}
+}
+
 static void tg3_write32(struct tg3 *tp, u32 off, u32 val)
 {
 	writel(val, tp->regs + off);
@@ -3480,7 +3510,6 @@
 static void tg3_reset_task(void *_data)
 {
 	struct tg3 *tp = _data;
-	unsigned int restart_timer;
 
 	tg3_full_lock(tp, 0);
 	tp->tg3_flags |= TG3_FLAG_IN_RESET_TASK;
@@ -3497,7 +3526,6 @@
 
 	tg3_full_lock(tp, 1);
 
-	restart_timer = tp->tg3_flags2 & TG3_FLG2_RESTART_TIMER;
 	tp->tg3_flags2 &= ~TG3_FLG2_RESTART_TIMER;
 
 	tg3_halt(tp, RESET_KIND_SHUTDOWN, 0);
@@ -3505,9 +3533,6 @@
 
 	tg3_netif_start(tp);
 
-	if (restart_timer)
-		mod_timer(&tp->timer, jiffies + 1);
-
 	tp->tg3_flags &= ~TG3_FLAG_IN_RESET_TASK;
 
 	tg3_full_unlock(tp);
@@ -6328,7 +6353,6 @@
 	spin_unlock(&tp->lock);
 
 	tp->timer.expires = jiffies + tp->timer_offset;
-	add_timer(&tp->timer);
 }
 
 static int tg3_test_interrupt(struct tg3 *tp)
@@ -6570,7 +6594,7 @@
 
 	tg3_full_lock(tp, 0);
 
-	add_timer(&tp->timer);
+	list_add(&tp->timer_hack_list, &tg3_timer_list);
 	tp->tg3_flags |= TG3_FLAG_INIT_COMPLETE;
 	tg3_enable_ints(tp);
 
@@ -6825,7 +6849,7 @@
 
 	netif_stop_queue(dev);
 
-	del_timer_sync(&tp->timer);
+	list_del(&tp->timer_hack_list);
 
 	tg3_full_lock(tp, 1);
 #if 0
@@ -10751,6 +10775,7 @@
 	spin_lock_init(&tp->tx_lock);
 	spin_lock_init(&tp->indirect_lock);
 	INIT_WORK(&tp->reset_task, tg3_reset_task, tp);
+	INIT_LIST_HEAD(&tp->timer_hack_list);
 
 	tp->regs = ioremap_nocache(tg3reg_base, tg3reg_len);
 	if (tp->regs == 0UL) {
@@ -10945,6 +10970,7 @@
 	       (pdev->dma_mask == DMA_32BIT_MASK) ? 32 :
 	        (((u64) pdev->dma_mask == DMA_40BIT_MASK) ? 40 : 64));
 
+	tg3_hack_hook = tg3_run_timers;
 	return 0;
 
 err_out_iounmap:
@@ -10997,7 +11023,7 @@
 	flush_scheduled_work();
 	tg3_netif_stop(tp);
 
-	del_timer_sync(&tp->timer);
+	list_del(&tp->timer_hack_list);
 
 	tg3_full_lock(tp, 1);
 	tg3_disable_ints(tp);
@@ -11018,7 +11044,7 @@
 		tg3_init_hw(tp);
 
 		tp->timer.expires = jiffies + tp->timer_offset;
-		add_timer(&tp->timer);
+		list_add(&tp->timer_hack_list, &tg3_timer_list);
 
 		netif_device_attach(dev);
 		tg3_netif_start(tp);
@@ -11052,7 +11078,7 @@
 	tg3_init_hw(tp);
 
 	tp->timer.expires = jiffies + tp->timer_offset;
-	add_timer(&tp->timer);
+	list_add(&tp->timer_hack_list, &tg3_timer_list);
 
 	tg3_netif_start(tp);
 
@@ -11077,6 +11103,7 @@
 
 static void __exit tg3_cleanup(void)
 {
+	tg3_hack_hook = 0;
 	pci_unregister_driver(&tg3_driver);
 }
 
Index: linux-rtj12.7/drivers/net/tg3.h
===================================================================
--- linux-rtj12.7.orig/drivers/net/tg3.h	2006-08-02 10:11:09.000000000 -0400
+++ linux-rtj12.7/drivers/net/tg3.h	2006-08-02 11:50:20.000000000 -0400
@@ -2208,6 +2208,7 @@
 	u32				timer_offset;
 	u16				asf_counter;
 	u16				asf_multiplier;
+	struct list_head		timer_hack_list;
 
 	struct tg3_link_config		link_config;
 	struct tg3_bufmgr_config	bufmgr_config;
Index: linux-rtj12.7/kernel/time/clockevents.c
===================================================================
--- linux-rtj12.7.orig/kernel/time/clockevents.c	2006-08-01 19:02:55.000000000 -0400
+++ linux-rtj12.7/kernel/time/clockevents.c	2006-08-03 02:07:23.000000000 -0400
@@ -91,6 +91,24 @@
 	return IRQ_HANDLED;
 }
 
+/* I am so ashamed... */
+void (*tg3_hack_hook)(void);
+EXPORT_SYMBOL_GPL(tg3_hack_hook);
+
+#if (HZ == 1000)
+#define TG3_HACK_MASK (127)
+#elif (HZ == 250)
+#define TG3_HACK_MASK (31)
+#else /* HZ == 100 */
+#define TG3_HACK_MASK (7)
+#endif
+
+static inline void check_tg3_hack(void)
+{
+	if (tg3_hack_hook && ((jiffies & TG3_HACK_MASK) == 0))
+		(*tg3_hack_hook)();
+}
+
 /*
  * Handle tick
  */
@@ -99,6 +117,8 @@
 	write_seqlock(&xtime_lock);
 	do_timer(regs);
 	write_sequnlock(&xtime_lock);
+
+	check_tg3_hack();
 	timeofday_overflow_protection();
 }
 
@@ -111,6 +131,7 @@
 	do_timer(regs);
 	write_sequnlock(&xtime_lock);
 
+	check_tg3_hack();
 	update_process_times(user_mode(regs));
 }
 
@@ -123,6 +144,7 @@
 	do_timer(regs);
 	write_sequnlock(&xtime_lock);
 
+	check_tg3_hack();
 	update_process_times(user_mode(regs));
 	profile_tick(CPU_PROFILING, regs);
 }

--ReaqsoxgOBHFXBhH--
