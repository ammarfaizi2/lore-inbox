Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288414AbSA0TcM>; Sun, 27 Jan 2002 14:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288452AbSA0TcC>; Sun, 27 Jan 2002 14:32:02 -0500
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:6792 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S288414AbSA0Tbo>; Sun, 27 Jan 2002 14:31:44 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Val Henson <val@nmt.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Athlon/AGP issue update
Date: Sun, 27 Jan 2002 20:32:17 +0100
Message-Id: <20020127193217.107@smtp.wanadoo.fr>
In-Reply-To: <20020127122235.D11111@boardwalk>
In-Reply-To: <20020127122235.D11111@boardwalk>
X-Mailer: CTM PowerMail 3.1.1 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I don't think we use the io mapping BATs any more, do we ? (well,
>> maybe on PReP...) I don't on pmac.
>
>Lots and lots of PPC platforms use BATs for io mappings:
>
>val@evilcat </sys/linuxppc_2_4_devel_pristine/arch/ppc/platforms>$ grep -
>l ppc_md.setup_io_mappings *
>grep: SCCS: Is a directory
>adir_setup.c
>apus_setup.c
>chrp_setup.c
>gemini_setup.c
>k2_setup.c
>lopec_setup.c
>mcpn765_setup.c
>menf1_setup.c
>mvme5100_setup.c
>pcore_setup.c
>powerpmc250.c
>pplus_setup.c
>prep_setup.c
>prpmc750_setup.c
>prpmc800_setup.c
>sandpoint_setup.c
>spruce_setup.c
>zx4500_setup.c

Hrm... all of these ? well... I don't like that. I'd prefer a lot
people to just properly ioremap what they need.
But well... I don't maintain all of them.

------------------ RFC822 Header Follows ------------------
From: <benh@kernel.crashing.org>
To: Val Henson <val@nmt.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Athlon/AGP issue update
Date: Sun, 27 Jan 2002 20:32:01 +0100
Message-Id: <20020127193201.5886@mailhost.mipsys.com>
In-Reply-To: <20020127122235.D11111@boardwalk>
In-Reply-To: <20020127122235.D11111@boardwalk>
X-Mailer: CTM PowerMail 3.1.1 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
-----------------------------------------------------------



