Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030623AbWJJWkB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030623AbWJJWkB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 18:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030624AbWJJWjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 18:39:54 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:64642 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030623AbWJJWj1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 18:39:27 -0400
To: torvalds@osdl.org
Subject: [PATCH 16/16] endianness annotations in s2io
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXQFy-00006h-09@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 23:39:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: Sun, 13 Aug 2006 15:38:04 -0400

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/net/s2io.h |  322 ++++++++++++++++++++++++++--------------------------
 1 files changed, 161 insertions(+), 161 deletions(-)

diff --git a/drivers/net/s2io.h b/drivers/net/s2io.h
index 72f52dc..12b719f 100644
--- a/drivers/net/s2io.h
+++ b/drivers/net/s2io.h
@@ -116,179 +116,179 @@ typedef struct {
 /* The statistics block of Xena */
 typedef struct stat_block {
 /* Tx MAC statistics counters. */
-	u32 tmac_data_octets;
-	u32 tmac_frms;
-	u64 tmac_drop_frms;
-	u32 tmac_bcst_frms;
-	u32 tmac_mcst_frms;
-	u64 tmac_pause_ctrl_frms;
-	u32 tmac_ucst_frms;
-	u32 tmac_ttl_octets;
-	u32 tmac_any_err_frms;
-	u32 tmac_nucst_frms;
-	u64 tmac_ttl_less_fb_octets;
-	u64 tmac_vld_ip_octets;
-	u32 tmac_drop_ip;
-	u32 tmac_vld_ip;
-	u32 tmac_rst_tcp;
-	u32 tmac_icmp;
-	u64 tmac_tcp;
-	u32 reserved_0;
-	u32 tmac_udp;
+	__le32 tmac_data_octets;
+	__le32 tmac_frms;
+	__le64 tmac_drop_frms;
+	__le32 tmac_bcst_frms;
+	__le32 tmac_mcst_frms;
+	__le64 tmac_pause_ctrl_frms;
+	__le32 tmac_ucst_frms;
+	__le32 tmac_ttl_octets;
+	__le32 tmac_any_err_frms;
+	__le32 tmac_nucst_frms;
+	__le64 tmac_ttl_less_fb_octets;
+	__le64 tmac_vld_ip_octets;
+	__le32 tmac_drop_ip;
+	__le32 tmac_vld_ip;
+	__le32 tmac_rst_tcp;
+	__le32 tmac_icmp;
+	__le64 tmac_tcp;
+	__le32 reserved_0;
+	__le32 tmac_udp;
 
 /* Rx MAC Statistics counters. */
-	u32 rmac_data_octets;
-	u32 rmac_vld_frms;
-	u64 rmac_fcs_err_frms;
-	u64 rmac_drop_frms;
-	u32 rmac_vld_bcst_frms;
-	u32 rmac_vld_mcst_frms;
-	u32 rmac_out_rng_len_err_frms;
-	u32 rmac_in_rng_len_err_frms;
-	u64 rmac_long_frms;
-	u64 rmac_pause_ctrl_frms;
-	u64 rmac_unsup_ctrl_frms;
-	u32 rmac_accepted_ucst_frms;
-	u32 rmac_ttl_octets;
-	u32 rmac_discarded_frms;
-	u32 rmac_accepted_nucst_frms;
-	u32 reserved_1;
-	u32 rmac_drop_events;
-	u64 rmac_ttl_less_fb_octets;
-	u64 rmac_ttl_frms;
-	u64 reserved_2;
-	u32 rmac_usized_frms;
-	u32 reserved_3;
-	u32 rmac_frag_frms;
-	u32 rmac_osized_frms;
-	u32 reserved_4;
-	u32 rmac_jabber_frms;
-	u64 rmac_ttl_64_frms;
-	u64 rmac_ttl_65_127_frms;
-	u64 reserved_5;
-	u64 rmac_ttl_128_255_frms;
-	u64 rmac_ttl_256_511_frms;
-	u64 reserved_6;
-	u64 rmac_ttl_512_1023_frms;
-	u64 rmac_ttl_1024_1518_frms;
-	u32 rmac_ip;
-	u32 reserved_7;
-	u64 rmac_ip_octets;
-	u32 rmac_drop_ip;
-	u32 rmac_hdr_err_ip;
-	u32 reserved_8;
-	u32 rmac_icmp;
-	u64 rmac_tcp;
-	u32 rmac_err_drp_udp;
-	u32 rmac_udp;
-	u64 rmac_xgmii_err_sym;
-	u64 rmac_frms_q0;
-	u64 rmac_frms_q1;
-	u64 rmac_frms_q2;
-	u64 rmac_frms_q3;
-	u64 rmac_frms_q4;
-	u64 rmac_frms_q5;
-	u64 rmac_frms_q6;
-	u64 rmac_frms_q7;
-	u16 rmac_full_q3;
-	u16 rmac_full_q2;
-	u16 rmac_full_q1;
-	u16 rmac_full_q0;
-	u16 rmac_full_q7;
-	u16 rmac_full_q6;
-	u16 rmac_full_q5;
-	u16 rmac_full_q4;
-	u32 reserved_9;
-	u32 rmac_pause_cnt;
-	u64 rmac_xgmii_data_err_cnt;
-	u64 rmac_xgmii_ctrl_err_cnt;
-	u32 rmac_err_tcp;
-	u32 rmac_accepted_ip;
+	__le32 rmac_data_octets;
+	__le32 rmac_vld_frms;
+	__le64 rmac_fcs_err_frms;
+	__le64 rmac_drop_frms;
+	__le32 rmac_vld_bcst_frms;
+	__le32 rmac_vld_mcst_frms;
+	__le32 rmac_out_rng_len_err_frms;
+	__le32 rmac_in_rng_len_err_frms;
+	__le64 rmac_long_frms;
+	__le64 rmac_pause_ctrl_frms;
+	__le64 rmac_unsup_ctrl_frms;
+	__le32 rmac_accepted_ucst_frms;
+	__le32 rmac_ttl_octets;
+	__le32 rmac_discarded_frms;
+	__le32 rmac_accepted_nucst_frms;
+	__le32 reserved_1;
+	__le32 rmac_drop_events;
+	__le64 rmac_ttl_less_fb_octets;
+	__le64 rmac_ttl_frms;
+	__le64 reserved_2;
+	__le32 rmac_usized_frms;
+	__le32 reserved_3;
+	__le32 rmac_frag_frms;
+	__le32 rmac_osized_frms;
+	__le32 reserved_4;
+	__le32 rmac_jabber_frms;
+	__le64 rmac_ttl_64_frms;
+	__le64 rmac_ttl_65_127_frms;
+	__le64 reserved_5;
+	__le64 rmac_ttl_128_255_frms;
+	__le64 rmac_ttl_256_511_frms;
+	__le64 reserved_6;
+	__le64 rmac_ttl_512_1023_frms;
+	__le64 rmac_ttl_1024_1518_frms;
+	__le32 rmac_ip;
+	__le32 reserved_7;
+	__le64 rmac_ip_octets;
+	__le32 rmac_drop_ip;
+	__le32 rmac_hdr_err_ip;
+	__le32 reserved_8;
+	__le32 rmac_icmp;
+	__le64 rmac_tcp;
+	__le32 rmac_err_drp_udp;
+	__le32 rmac_udp;
+	__le64 rmac_xgmii_err_sym;
+	__le64 rmac_frms_q0;
+	__le64 rmac_frms_q1;
+	__le64 rmac_frms_q2;
+	__le64 rmac_frms_q3;
+	__le64 rmac_frms_q4;
+	__le64 rmac_frms_q5;
+	__le64 rmac_frms_q6;
+	__le64 rmac_frms_q7;
+	__le16 rmac_full_q3;
+	__le16 rmac_full_q2;
+	__le16 rmac_full_q1;
+	__le16 rmac_full_q0;
+	__le16 rmac_full_q7;
+	__le16 rmac_full_q6;
+	__le16 rmac_full_q5;
+	__le16 rmac_full_q4;
+	__le32 reserved_9;
+	__le32 rmac_pause_cnt;
+	__le64 rmac_xgmii_data_err_cnt;
+	__le64 rmac_xgmii_ctrl_err_cnt;
+	__le32 rmac_err_tcp;
+	__le32 rmac_accepted_ip;
 
 /* PCI/PCI-X Read transaction statistics. */
-	u32 new_rd_req_cnt;
-	u32 rd_req_cnt;
-	u32 rd_rtry_cnt;
-	u32 new_rd_req_rtry_cnt;
+	__le32 new_rd_req_cnt;
+	__le32 rd_req_cnt;
+	__le32 rd_rtry_cnt;
+	__le32 new_rd_req_rtry_cnt;
 
 /* PCI/PCI-X Write/Read transaction statistics. */
-	u32 wr_req_cnt;
-	u32 wr_rtry_rd_ack_cnt;
-	u32 new_wr_req_rtry_cnt;
-	u32 new_wr_req_cnt;
-	u32 wr_disc_cnt;
-	u32 wr_rtry_cnt;
+	__le32 wr_req_cnt;
+	__le32 wr_rtry_rd_ack_cnt;
+	__le32 new_wr_req_rtry_cnt;
+	__le32 new_wr_req_cnt;
+	__le32 wr_disc_cnt;
+	__le32 wr_rtry_cnt;
 
 /*	PCI/PCI-X Write / DMA Transaction statistics. */
-	u32 txp_wr_cnt;
-	u32 rd_rtry_wr_ack_cnt;
-	u32 txd_wr_cnt;
-	u32 txd_rd_cnt;
-	u32 rxd_wr_cnt;
-	u32 rxd_rd_cnt;
-	u32 rxf_wr_cnt;
-	u32 txf_rd_cnt;
+	__le32 txp_wr_cnt;
+	__le32 rd_rtry_wr_ack_cnt;
+	__le32 txd_wr_cnt;
+	__le32 txd_rd_cnt;
+	__le32 rxd_wr_cnt;
+	__le32 rxd_rd_cnt;
+	__le32 rxf_wr_cnt;
+	__le32 txf_rd_cnt;
 
 /* Tx MAC statistics overflow counters. */
-	u32 tmac_data_octets_oflow;
-	u32 tmac_frms_oflow;
-	u32 tmac_bcst_frms_oflow;
-	u32 tmac_mcst_frms_oflow;
-	u32 tmac_ucst_frms_oflow;
-	u32 tmac_ttl_octets_oflow;
-	u32 tmac_any_err_frms_oflow;
-	u32 tmac_nucst_frms_oflow;
-	u64 tmac_vlan_frms;
-	u32 tmac_drop_ip_oflow;
-	u32 tmac_vld_ip_oflow;
-	u32 tmac_rst_tcp_oflow;
-	u32 tmac_icmp_oflow;
-	u32 tpa_unknown_protocol;
-	u32 tmac_udp_oflow;
-	u32 reserved_10;
-	u32 tpa_parse_failure;
+	__le32 tmac_data_octets_oflow;
+	__le32 tmac_frms_oflow;
+	__le32 tmac_bcst_frms_oflow;
+	__le32 tmac_mcst_frms_oflow;
+	__le32 tmac_ucst_frms_oflow;
+	__le32 tmac_ttl_octets_oflow;
+	__le32 tmac_any_err_frms_oflow;
+	__le32 tmac_nucst_frms_oflow;
+	__le64 tmac_vlan_frms;
+	__le32 tmac_drop_ip_oflow;
+	__le32 tmac_vld_ip_oflow;
+	__le32 tmac_rst_tcp_oflow;
+	__le32 tmac_icmp_oflow;
+	__le32 tpa_unknown_protocol;
+	__le32 tmac_udp_oflow;
+	__le32 reserved_10;
+	__le32 tpa_parse_failure;
 
 /* Rx MAC Statistics overflow counters. */
-	u32 rmac_data_octets_oflow;
-	u32 rmac_vld_frms_oflow;
-	u32 rmac_vld_bcst_frms_oflow;
-	u32 rmac_vld_mcst_frms_oflow;
-	u32 rmac_accepted_ucst_frms_oflow;
-	u32 rmac_ttl_octets_oflow;
-	u32 rmac_discarded_frms_oflow;
-	u32 rmac_accepted_nucst_frms_oflow;
-	u32 rmac_usized_frms_oflow;
-	u32 rmac_drop_events_oflow;
-	u32 rmac_frag_frms_oflow;
-	u32 rmac_osized_frms_oflow;
-	u32 rmac_ip_oflow;
-	u32 rmac_jabber_frms_oflow;
-	u32 rmac_icmp_oflow;
-	u32 rmac_drop_ip_oflow;
-	u32 rmac_err_drp_udp_oflow;
-	u32 rmac_udp_oflow;
-	u32 reserved_11;
-	u32 rmac_pause_cnt_oflow;
-	u64 rmac_ttl_1519_4095_frms;
-	u64 rmac_ttl_4096_8191_frms;
-	u64 rmac_ttl_8192_max_frms;
-	u64 rmac_ttl_gt_max_frms;
-	u64 rmac_osized_alt_frms;
-	u64 rmac_jabber_alt_frms;
-	u64 rmac_gt_max_alt_frms;
-	u64 rmac_vlan_frms;
-	u32 rmac_len_discard;
-	u32 rmac_fcs_discard;
-	u32 rmac_pf_discard;
-	u32 rmac_da_discard;
-	u32 rmac_red_discard;
-	u32 rmac_rts_discard;
-	u32 reserved_12;
-	u32 rmac_ingm_full_discard;
-	u32 reserved_13;
-	u32 rmac_accepted_ip_oflow;
-	u32 reserved_14;
-	u32 link_fault_cnt;
+	__le32 rmac_data_octets_oflow;
+	__le32 rmac_vld_frms_oflow;
+	__le32 rmac_vld_bcst_frms_oflow;
+	__le32 rmac_vld_mcst_frms_oflow;
+	__le32 rmac_accepted_ucst_frms_oflow;
+	__le32 rmac_ttl_octets_oflow;
+	__le32 rmac_discarded_frms_oflow;
+	__le32 rmac_accepted_nucst_frms_oflow;
+	__le32 rmac_usized_frms_oflow;
+	__le32 rmac_drop_events_oflow;
+	__le32 rmac_frag_frms_oflow;
+	__le32 rmac_osized_frms_oflow;
+	__le32 rmac_ip_oflow;
+	__le32 rmac_jabber_frms_oflow;
+	__le32 rmac_icmp_oflow;
+	__le32 rmac_drop_ip_oflow;
+	__le32 rmac_err_drp_udp_oflow;
+	__le32 rmac_udp_oflow;
+	__le32 reserved_11;
+	__le32 rmac_pause_cnt_oflow;
+	__le64 rmac_ttl_1519_4095_frms;
+	__le64 rmac_ttl_4096_8191_frms;
+	__le64 rmac_ttl_8192_max_frms;
+	__le64 rmac_ttl_gt_max_frms;
+	__le64 rmac_osized_alt_frms;
+	__le64 rmac_jabber_alt_frms;
+	__le64 rmac_gt_max_alt_frms;
+	__le64 rmac_vlan_frms;
+	__le32 rmac_len_discard;
+	__le32 rmac_fcs_discard;
+	__le32 rmac_pf_discard;
+	__le32 rmac_da_discard;
+	__le32 rmac_red_discard;
+	__le32 rmac_rts_discard;
+	__le32 reserved_12;
+	__le32 rmac_ingm_full_discard;
+	__le32 reserved_13;
+	__le32 rmac_accepted_ip_oflow;
+	__le32 reserved_14;
+	__le32 link_fault_cnt;
 	u8  buffer[20];
 	swStat_t sw_stat;
 	xpakStat_t xpak_stat;
-- 
1.4.2.GIT

