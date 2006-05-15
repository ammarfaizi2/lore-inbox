Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751626AbWEORki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626AbWEORki (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 13:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751628AbWEORki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 13:40:38 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:29432 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751626AbWEORkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 13:40:37 -0400
Message-ID: <4468BD2D.5000103@de.ibm.com>
Date: Mon, 15 May 2006 19:41:01 +0200
From: Heiko J Schick <schihei@de.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: openib-general@openib.org, Christoph Raisch <RAISCH@de.ibm.com>,
       Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>,
       schihei@de.ibm.com, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: [PATCH 00/16] ehca: IBM eHCA InfiniBand Device Driver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

many thanks for your comments. They are very helpful for us. All
17 patches have to be applied, otherwise the driver won't compile.

We would appreciate for any comments and feedbacks.

Signed-off-by: Heiko J Schick <schickhj@de.ibm.com>
Changelog-by:  Heiko J Schick <schickhj@de.ibm.com>

Changelog:

Differences to PatchSet http://openib.org/pipermail/openib-general/2006-April/020584.html
Differences to PatchSet http://openib.org/pipermail/openib-general/2006-March/018144.html
Differences to PatchSet http://openib.org/pipermail/openib-general/2006-March/017412.html

- Linux kernel coding style
- Reduce number of parameters passed to firmware interface wrappers
- Remove ehca_kernel.h
- Remove implementation of plpar_hcall_7arg_7ret() and plpar_hcall_9arg_9ret(),
   which are now included in kernel code
- Remove simulation stub

  drivers/infiniband/hw/ehca/Kconfig                |    6
  drivers/infiniband/hw/ehca/Makefile               |   16
  drivers/infiniband/hw/ehca/ehca_av.c              |  306 ++
  drivers/infiniband/hw/ehca/ehca_classes.h         |  350 +++
  drivers/infiniband/hw/ehca/ehca_classes_pSeries.h |  251 ++
  drivers/infiniband/hw/ehca/ehca_cq.c              |  431 +++
  drivers/infiniband/hw/ehca/ehca_eq.c              |  222 +
  drivers/infiniband/hw/ehca/ehca_hca.c             |  282 ++
  drivers/infiniband/hw/ehca/ehca_irq.c             |  710 ++++++
  drivers/infiniband/hw/ehca/ehca_irq.h             |   77
  drivers/infiniband/hw/ehca/ehca_iverbs.h          |  181 +
  drivers/infiniband/hw/ehca/ehca_main.c            |  966 ++++++++
  drivers/infiniband/hw/ehca/ehca_mcast.c           |  194 +
  drivers/infiniband/hw/ehca/ehca_mrmw.c            | 2474 ++++++++++++++++++++++
  drivers/infiniband/hw/ehca/ehca_mrmw.h            |  143 +
  drivers/infiniband/hw/ehca/ehca_pd.c              |  118 +
  drivers/infiniband/hw/ehca/ehca_qes.h             |  274 ++
  drivers/infiniband/hw/ehca/ehca_qp.c              | 1565 +++++++++++++
  drivers/infiniband/hw/ehca/ehca_reqs.c            |  683 ++++++
  drivers/infiniband/hw/ehca/ehca_sqp.c             |  123 +
  drivers/infiniband/hw/ehca/ehca_tools.h           |  411 +++
  drivers/infiniband/hw/ehca/ehca_uverbs.c          |  391 +++
  drivers/infiniband/hw/ehca/hcp_if.c               | 1476 +++++++++++++
  drivers/infiniband/hw/ehca/hcp_if.h               |  330 ++
  drivers/infiniband/hw/ehca/hcp_phyp.c             |   92
  drivers/infiniband/hw/ehca/hcp_phyp.h             |   95
  drivers/infiniband/hw/ehca/hipz_fns.h             |   68
  drivers/infiniband/hw/ehca/hipz_fns_core.h        |  122 +
  drivers/infiniband/hw/ehca/hipz_hw.h              |  395 +++
  drivers/infiniband/hw/ehca/ipz_pt_fn.c            |  177 +
  drivers/infiniband/hw/ehca/ipz_pt_fn.h            |  254 ++
  31 files changed, 13183 insertions(+)


