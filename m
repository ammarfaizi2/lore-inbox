Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750855AbWIRTJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbWIRTJq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 15:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbWIRTJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 15:09:45 -0400
Received: from mails.tecomtech.com ([61.183.139.138]:3784 "EHLO
	titan.tecomtech.com") by vger.kernel.org with ESMTP
	id S1751615AbWIRNro convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 09:47:44 -0400
Message-Id: <200609181347.k8IDlhSO004336@titan.tecomtech.com>
From: "Echo.Li" <glli@tecomtech.com>
To: <linux-kernel@vger.kernel.org>
Subject: br_stp_if.c
Date: Mon, 18 Sep 2006 21:47:35 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
Thread-Index: AcbbJtFhERXxEvg6SkSUEpqspRQ4jwAAGHkgAAAUoSAAACkUUAAAMhag
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.
I read the bridge code of linux kernel. But now I meet a puzzle.  
In file net/bridge/br_stp_if.c line 157
Void br_stp_recalculate_bridge_id() {
….
List_for_each_entry(p, &br->port_list, list) {
     If (addr==br_mac_zeor ||
     Memcmp(p->dev->dev_addr, addr, ETH_ALEN) <0)  //why to find the min of
all macs????
         Add = p->dev->dev_addr;
}
…
}

Who can answer my question? Thanks very much!!!!

BR,
Echo


