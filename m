Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264502AbUGRUYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264502AbUGRUYa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 16:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbUGRUYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 16:24:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47842 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264502AbUGRUY2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 16:24:28 -0400
Date: Sun, 18 Jul 2004 16:23:51 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@devserv.devel.redhat.com
To: Carl Spalletta <cspalletta@yahoo.com>
cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: [PATCH] Remove prototypes of non-existent funcs from security/selinux
 files
In-Reply-To: <20040718184511.73905.qmail@web53802.mail.yahoo.com>
Message-ID: <Pine.LNX.4.58.0407181623390.31568@devserv.devel.redhat.com>
References: <20040718184511.73905.qmail@web53802.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks fine to me.

On Sun, 18 Jul 2004, Carl Spalletta wrote:
> diff -ru linux-2.6.7-orig/security/selinux/include/avc.h
> linux-2.6.7-new/security/selinux/include/avc.h
> --- linux-2.6.7-orig/security/selinux/include/avc.h     2004-06-15 22:19:01.000000000 -0700
> +++ linux-2.6.7-new/security/selinux/include/avc.h      2004-07-18 08:55:29.000000000 -0700
> @@ -130,7 +130,6 @@
>  struct audit_buffer;
>  void avc_dump_av(struct audit_buffer *ab, u16 tclass, u32 av);
>  void avc_dump_query(struct audit_buffer *ab, u32 ssid, u32 tsid, u16 tclass);
> -void avc_dump_cache(struct audit_buffer *ab, char *tag);
> 
>  /*
>   * AVC operations
> diff -ru linux-2.6.7-orig/security/selinux/ss/policydb.h
> linux-2.6.7-new/security/selinux/ss/policydb.h
> --- linux-2.6.7-orig/security/selinux/ss/policydb.h     2004-06-15 22:19:43.000000000 -0700
> +++ linux-2.6.7-new/security/selinux/ss/policydb.h      2004-07-18 08:55:15.000000000 -0700
> @@ -251,7 +251,6 @@
>  extern int policydb_init(struct policydb *p);
>  extern int policydb_index_classes(struct policydb *p);
>  extern int policydb_index_others(struct policydb *p);
> -extern int constraint_expr_destroy(struct constraint_expr *expr);
>  extern void policydb_destroy(struct policydb *p);
>  extern int policydb_load_isids(struct policydb *p, struct sidtab *s);
>  extern int policydb_context_isvalid(struct policydb *p, struct context *c);
> 

-- 
James Morris
<jmorris@redhat.com>

