Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbUL1FTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbUL1FTb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 00:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbUL1FTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 00:19:30 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:33449
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262068AbUL1FTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 00:19:16 -0500
Date: Mon, 27 Dec 2004 21:14:17 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: acme@conectiva.com.br, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] net/llc/: misc possible cleanups
Message-Id: <20041227211417.2d077475.davem@davemloft.net>
In-Reply-To: <20041215011211.GC12937@stusta.de>
References: <20041215011211.GC12937@stusta.de>
X-Mailer: Sylpheed version 1.0.0rc (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2004 02:12:11 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> The patch below contains the following possible cleanups:
> - make some needlessly global code static
> - remove the following unused global functions:
>   - lc_c_ac.c: llc_conn_ac_report_status
>   - lc_c_ac.c: llc_conn_ac_send_dm_rsp_f_set_f_flag
>   - lc_c_ac.c: llc_conn_ac_resend_i_cmd_p_set_1
>   - lc_c_ac.c: llc_conn_ac_resend_i_cmd_p_set_1_or_send_rr
>   - lc_c_ac.c: llc_conn_ac_send_ack_cmd_p_set_1
>   - lc_c_ac.c: llc_conn_ac_send_ua_rsp_f_set_f_flag
>   - lc_c_ac.c: llc_conn_ac_set_f_flag_p
>   - llc_c_ev.c: llc_conn_ev_conn_resp
>   - llc_c_ev.c: llc_conn_ev_rst_resp
>   - llc_c_ev.c: llc_conn_ev_rx_xxx_cmd_pbit_set_0
>   - llc_c_ev.c: llc_conn_ev_rx_xxx_yyy
>   - llc_c_ev.c: llc_conn_ev_any_tmr_exp
>   - llc_c_ev.c: llc_conn_ev_qlfy_init_p_f_cycle
>   - llc_c_ev.c: llc_conn_ev_qlfy_set_status_impossible
>   - llc_c_ev.c: llc_conn_ev_qlfy_set_status_received
>   - llc_if.c: llc_build_and_send_reset_pkt
>   - llc_pdu.c: llc_pdu_decode_cr_bit
> - remove the following unneeded EXPORT_SYMBOL:
>   - llc_core.c: llc_sap_list_lock

Also looks good, applied.

Thanks Adrian.
