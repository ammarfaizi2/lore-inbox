Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262735AbREVTNi>; Tue, 22 May 2001 15:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262734AbREVTN2>; Tue, 22 May 2001 15:13:28 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:64786 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262735AbREVTNQ>; Tue, 22 May 2001 15:13:16 -0400
Subject: Re: Xircom RealPort versus 3COM 3C3FEM656C
To: dax@gurulabs.com (Dax Kelson)
Date: Tue, 22 May 2001 20:10:41 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SOL.4.30.0105221254350.28868-100000@ultra1.inconnect.com> from "Dax Kelson" at May 22, 2001 01:07:45 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E152HYH-0002LB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I currently have three Xircom RealPort Carbus modem/fast ethernet cards.
> The current driver blows major chunks (it has very poor performance, and
> stops working under load).  I'm told the driver issues are because of
> hardware issues. The really nice feature of this card is the form factor
> though.

Before you give up on the xircom thing, try the -ac kernel and set the box
up to use xircom_cb not xircom_tulip_cb

That might help a lot

