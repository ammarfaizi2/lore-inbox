Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262911AbSJRGK7>; Fri, 18 Oct 2002 02:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264770AbSJRGK7>; Fri, 18 Oct 2002 02:10:59 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:34288 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S262911AbSJRGKx>; Fri, 18 Oct 2002 02:10:53 -0400
From: "Pavan Kumar Reddy N.S." <pavan.kumar@wipro.com>
To: "Pavan Kumar Reddy" <pavan.kumar@wipro.com>
Subject: HBench-OS 1.0 performance results for Linux kernel ver 2.4.20-pre11
Date: Fri, 18 Oct 2002 11:51:48 +0530
Message-ID: <FDEHKENEPHHCPKOJCKLGKEDLCCAA.pavan.kumar@wipro.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-0482c9cd-e82d-408d-ba80-5451d6c65bba"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-0482c9cd-e82d-408d-ba80-5451d6c65bba
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit


Hi,

Here I am putting the performance results of "HBench-OS 1.0" for
Linux Kernel 2.4.20-pre11. 


HW Details:
 868Mhz P3 with 128Mb RAM with ext3 file system.

Thanks,
pavan.


=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
HBench-OS 1.0 Summary Output for Linux kernel ver 2.4.20-pre11
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

System name: access1
System type: i686-pc-linux
Architecture: i686
OS type: linux-2.4.20-pre11
Testset: full.test
Runs: 10

Counter mode: none

lat_syscall:
   getpid: 0.360883 (std. 0.007048, 1.95%) [median 0.362100]
   getrusage: 0.561700 (std. 0.007230, 1.29%) [median 0.562450]
   gettimeofday: 0.552867 (std. 0.005697, 1.03%) [median 0.551650]
   sbrk: 0.035750 (std. 0.000055, 0.15%) [median 0.035750]
   sigaction: 0.717183 (std. 0.002885, 0.40%) [median 0.715900]
   write: 0.634250 (std. 0.007440, 1.17%) [median 0.635850]

lat_fslayer:
   <default>: 0.617817 (std. 0.001617, 0.26%) [median 0.617700]

lat_sig:
   handle: 1.725383 (std. 0.000232, 0.01%) [median 1.725300]
   install: 0.797917 (std. 0.002198, 0.28%) [median 0.797600]

lat_pipe:
   <default>: 6.151867 (std. 0.012764, 0.21%) [median 6.151550]

lat_proc:
   null dummy: 132.203667 (std. 0.561716, 0.42%) [median 132.344700]
   sh dynamic: 5066.602867 (std. 9.277116, 0.18%) [median 5063.248050]
   sh static: 4474.042333 (std. 18.464647, 0.41%) [median 4481.636700]
   simple dynamic: 797.993483 (std. 7.097108, 0.89%) [median 798.366700]
   simple static: 195.967950 (std. 4.369844, 2.23%) [median 195.314050]

lat_mmap:
   4k: 2.907650 (std. 0.013970, 0.48%) [median 2.908150]
   8k: 2.956300 (std. 0.043954, 1.49%) [median 2.961100]
   32k: 2.975283 (std. 0.021780, 0.73%) [median 2.967850]
   64k: 3.040767 (std. 0.038613, 1.27%) [median 3.051350]
   256k: 3.434100 (std. 0.066474, 1.94%) [median 3.442150]
   512k: 3.792567 (std. 0.020403, 0.54%) [median 3.788250]
   1m: 4.605567 (std. 0.056870, 1.23%) [median 4.588750]
   2m: 6.671467 (std. 0.186704, 2.80%) [median 6.723900]
   3m: 8.239967 (std. 0.264563, 3.21%) [median 8.242150]
   4m: 10.639833 (std. 0.350798, 3.30%) [median 10.803100]
   8m: 10.445400 (std. 0.510413, 4.89%) [median 10.379500]

bw_mem_rd:
   2k: 1162.258667 (std. 0.069116, 0.01%) [median 1162.274500]
   4k: 3251.036183 (std. 0.646657, 0.02%) [median 3251.155000]
   8k: 3248.862067 (std. 0.472468, 0.01%) [median 3248.849700]
   16k: 3260.904167 (std. 0.465637, 0.01%) [median 3261.012200]
   32k: 2032.606617 (std. 0.338053, 0.02%) [median 2032.634450]
   64k: 2033.852000 (std. 0.170787, 0.01%) [median 2033.808400]
   128k: 1626.409567 (std. 629.424097, 38.70%) [median 2031.790650]
   256k: 684.896167 (std. 62.961178, 9.19%) [median 711.158900]
   512k: 339.719167 (std. 0.124329, 0.04%) [median 339.703000]
   1m: 339.734767 (std. 0.203334, 0.06%) [median 339.812300]
   2m: 339.688450 (std. 0.149552, 0.04%) [median 339.663100]
   4m: 339.953817 (std. 0.059363, 0.02%) [median 339.952700]
   8m: 339.938567 (std. 0.065171, 0.02%) [median 339.942550]

bw_mem_wr:
   2k: 2828.221067 (std. 0.642235, 0.02%) [median 2828.248100]
   4k: 2842.262650 (std. 0.403076, 0.01%) [median 2842.311050]
   8k: 2832.687050 (std. 0.336504, 0.01%) [median 2832.623500]
   16k: 2841.563000 (std. 0.282273, 0.01%) [median 2841.578100]
   32k: 2033.436317 (std. 0.101083, 0.00%) [median 2033.437850]
   64k: 2034.393817 (std. 0.083433, 0.00%) [median 2034.410150]
   128k: 2192.512850 (std. 0.169106, 0.01%) [median 2192.568300]
   256k: 727.696967 (std. 74.082064, 10.18%) [median 736.119450]
   512k: 165.939683 (std. 0.227314, 0.14%) [median 165.999250]
   1m: 138.261467 (std. 0.042207, 0.03%) [median 138.258900]
   2m: 136.634167 (std. 0.023253, 0.02%) [median 136.641650]
   4m: 136.578483 (std. 0.011478, 0.01%) [median 136.579400]
   8m: 136.593317 (std. 0.014256, 0.01%) [median 136.597450]

bw_bzero:
   256k: 657.365483 (std. 76.956034, 11.71%) [median 611.967650]
   512k: 181.655133 (std. 0.800824, 0.44%) [median 181.695000]
   1m: 149.510467 (std. 0.056490, 0.04%) [median 149.493000]
   2m: 146.806567 (std. 0.044944, 0.03%) [median 146.819850]
   4m: 146.470833 (std. 0.029431, 0.02%) [median 146.466700]
   8m: 146.313167 (std. 0.030129, 0.02%) [median 146.301000]

bw_mem_cp:
   2k unrolled aligned: 2003.777033 (std. 0.387197, 0.02%) [median 2003.678650]
   2k unrolled unaligned: 2004.013933 (std. 0.243499, 0.01%) [median 2004.130600]
   4k unrolled aligned: 2029.055100 (std. 0.428695, 0.02%) [median 2029.098950]
   4k unrolled unaligned: 2028.867800 (std. 0.308778, 0.02%) [median 2028.839600]
   8k unrolled aligned: 2061.227233 (std. 1.833876, 0.09%) [median 2061.154750]
   8k unrolled unaligned: 2081.600200 (std. 0.381515, 0.02%) [median 2081.575800]
   16k libc aligned: 1766.036817 (std. 3.568149, 0.20%) [median 1765.760250]
   16k libc unaligned: 1713.683500 (std. 0.132105, 0.01%) [median 1713.715750]
   16k unrolled aligned: 1320.947600 (std. 0.670614, 0.05%) [median 1321.059500]
   16k unrolled unaligned: 1247.558050 (std. 0.110709, 0.01%) [median 1247.526150]
   32k libc aligned: 1784.691950 (std. 0.294684, 0.02%) [median 1784.699700]
   32k libc unaligned: 1730.538267 (std. 0.207393, 0.01%) [median 1730.573800]
   32k unrolled aligned: 1317.411883 (std. 0.456752, 0.03%) [median 1317.584100]
   32k unrolled unaligned: 1240.152000 (std. 1.983750, 0.16%) [median 1240.341500]
   64k libc aligned: 1790.770317 (std. 1.412004, 0.08%) [median 1790.802300]
   64k libc unaligned: 1738.495033 (std. 0.571892, 0.03%) [median 1738.551700]
   64k unrolled aligned: 881.562550 (std. 461.170018, 52.31%) [median 878.091450]
   64k unrolled unaligned: 1236.735050 (std. 13.127684, 1.06%) [median 1240.888850]
   128k libc aligned: 361.226700 (std. 29.673799, 8.21%) [median 363.674350]
   128k libc unaligned: 365.374183 (std. 44.099273, 12.07%) [median 352.263350]
   128k unrolled aligned: 276.988050 (std. 22.085449, 7.97%) [median 273.218250]
   128k unrolled unaligned: 254.948717 (std. 19.547776, 7.67%) [median 259.194700]
   256k libc aligned: 135.401433 (std. 0.545379, 0.40%) [median 135.359150]
   256k libc unaligned: 139.199083 (std. 1.946632, 1.40%) [median 139.455200]
   256k unrolled aligned: 112.278983 (std. 0.395518, 0.35%) [median 112.310700]
   256k unrolled unaligned: 113.759783 (std. 1.136641, 1.00%) [median 113.578350]
   512k libc aligned: 104.152733 (std. 0.281752, 0.27%) [median 104.063750]
   512k libc unaligned: 104.732517 (std. 0.328718, 0.31%) [median 104.668200]
   512k unrolled aligned: 91.614767 (std. 0.134768, 0.15%) [median 91.597300]
   512k unrolled unaligned: 90.065633 (std. 0.192628, 0.21%) [median 90.013500]
   1m libc aligned: 93.733867 (std. 0.087517, 0.09%) [median 93.758900]
   1m libc unaligned: 93.619150 (std. 0.088917, 0.09%) [median 93.594450]
   1m unrolled aligned: 83.650200 (std. 0.094925, 0.11%) [median 83.680600]
   1m unrolled unaligned: 84.144700 (std. 0.103111, 0.12%) [median 84.171450]
   2m libc aligned: 91.885283 (std. 0.029880, 0.03%) [median 91.877100]
   2m libc unaligned: 91.487650 (std. 0.043813, 0.05%) [median 91.474900]
   2m unrolled aligned: 81.393733 (std. 0.122945, 0.15%) [median 81.385300]
   2m unrolled unaligned: 81.217350 (std. 0.451688, 0.56%) [median 81.437000]
   4m libc aligned: 91.429517 (std. 0.221652, 0.24%) [median 91.377600]
   4m libc unaligned: 90.977250 (std. 0.155717, 0.17%) [median 90.893050]
   4m unrolled aligned: 81.376850 (std. 0.079809, 0.10%) [median 81.362050]
   4m unrolled unaligned: 80.861417 (std. 0.057268, 0.07%) [median 80.844050]
   8m libc aligned: 91.130350 (std. 0.047233, 0.05%) [median 91.137100]
   8m libc unaligned: 90.684650 (std. 0.023272, 0.03%) [median 90.693850]
   8m unrolled aligned: 80.746233 (std. 0.024686, 0.03%) [median 80.735050]
   8m unrolled unaligned: 80.674033 (std. 0.018905, 0.02%) [median 80.681750]

bw_file_rd:
   32k 32k: 826.072767 (std. 9.073808, 1.10%) [median 822.368400]
   64k 32k: 767.430967 (std. 22.543263, 2.94%) [median 776.427450]
   64k 64k: 731.350400 (std. 17.629067, 2.41%) [median 735.294100]
   128k 32k: 480.913133 (std. 25.014528, 5.20%) [median 472.632000]
   128k 64k: 491.857483 (std. 24.048835, 4.89%) [median 497.067000]
   256k 32k: 323.952283 (std. 4.346769, 1.34%) [median 321.957600]
   256k 64k: 313.527383 (std. 12.971524, 4.14%) [median 310.945750]
   512k 4k: 300.605683 (std. 1.270300, 0.42%) [median 300.390550]
   512k 8k: 300.363967 (std. 8.309363, 2.77%) [median 297.798950]
   512k 16k: 306.161633 (std. 11.888961, 3.88%) [median 304.140300]
   512k 32k: 321.905700 (std. 15.998500, 4.97%) [median 326.181350]
   512k 64k: 300.425217 (std. 1.286514, 0.43%) [median 300.843350]
   512k 128k: 102.681383 (std. 2.955658, 2.88%) [median 103.477600]
   512k 256k: 72.314217 (std. 1.477244, 2.04%) [median 72.160650]
   512k 512k: 61.718667 (std. 1.063436, 1.72%) [median 62.119600]
   1m 4k: 304.061900 (std. 5.980925, 1.97%) [median 301.932400]
   1m 8k: 299.586333 (std. 2.745796, 0.92%) [median 298.596650]
   1m 16k: 299.020600 (std. 3.683822, 1.23%) [median 297.752000]
   1m 32k: 301.918633 (std. 2.458127, 0.81%) [median 301.387750]
   1m 64k: 301.817683 (std. 1.570564, 0.52%) [median 301.934100]
   1m 128k: 106.983667 (std. 4.143842, 3.87%) [median 106.310850]
   1m 256k: 73.020683 (std. 0.342106, 0.47%) [median 73.038100]
   1m 512k: 64.887417 (std. 0.248712, 0.38%) [median 64.823750]
   1m 1m: 63.776933 (std. 0.064983, 0.10%) [median 63.775550]
   2m 4k: 309.027750 (std. 4.711835, 1.52%) [median 309.335750]
   2m 8k: 304.649400 (std. 3.930153, 1.29%) [median 304.956700]
   2m 16k: 302.256133 (std. 5.678357, 1.88%) [median 299.670400]
   2m 32k: 308.319717 (std. 4.639017, 1.50%) [median 309.119600]
   2m 64k: 305.465650 (std. 5.812509, 1.90%) [median 302.732550]
   2m 128k: 108.242000 (std. 4.412035, 4.08%) [median 108.958250]
   2m 256k: 73.907867 (std. 0.167689, 0.23%) [median 73.934450]
   2m 512k: 66.845000 (std. 0.067865, 0.10%) [median 66.850550]
   2m 1m: 65.522933 (std. 0.033289, 0.05%) [median 65.529700]
   2m 2m: 66.253017 (std. 0.064953, 0.10%) [median 66.246050]
   3m 1m: 66.217900 (std. 0.053448, 0.08%) [median 66.198150]
   4m 32k: 305.104317 (std. 1.398202, 0.46%) [median 305.822100]
   4m 64k: 304.262467 (std. 1.565454, 0.51%) [median 304.114400]
   4m 1m: 66.879450 (std. 0.078770, 0.12%) [median 66.866700]
   5m 1m: 66.740417 (std. 0.049455, 0.07%) [median 66.725850]
   6m 1m: 67.146667 (std. 0.056512, 0.08%) [median 67.124600]
   7m 1m: 67.256867 (std. 0.042379, 0.06%) [median 67.253050]
   8m 32k: 304.761350 (std. 0.712932, 0.23%) [median 304.838000]
   8m 64k: 305.035217 (std. 1.485759, 0.49%) [median 305.228500]
   8m 1m: 67.337633 (std. 0.037266, 0.06%) [median 67.326200]

bw_mmap_rd:
   4k: 1218.583883 (std. 129.778661, 10.65%) [median 1271.565800]
   8k: 1398.722350 (std. 139.293022, 9.96%) [median 1398.722350]
   16k: 1290.831933 (std. 47.192196, 3.66%) [median 1271.565800]
   32k: 1254.611567 (std. 26.265385, 2.09%) [median 1271.565800]
   64k: 1269.943833 (std. 13.568197, 1.07%) [median 1261.185600]
   128k: 1243.632750 (std. 7.866206, 0.63%) [median 1243.591300]
   256k: 399.581333 (std. 9.751065, 2.44%) [median 400.243750]
   512k: 296.957867 (std. 1.053892, 0.35%) [median 297.102300]
   1m: 294.170600 (std. 8.275980, 2.81%) [median 290.962450]
   2m: 295.990100 (std. 5.768783, 1.95%) [median 297.407250]
   4m: 294.122750 (std. 0.377324, 0.13%) [median 294.133450]
   8m: 293.271683 (std. 0.248571, 0.08%) [median 293.293100]

bw_pipe:
   4k: 578.346683 (std. 3.870504, 0.67%) [median 578.721000]
   8k: 608.017033 (std. 3.648525, 0.60%) [median 608.903550]
   16k: 646.910933 (std. 4.115511, 0.64%) [median 647.435150]
   32k: 672.526350 (std. 4.913303, 0.73%) [median 669.812150]
   64k: 640.070983 (std. 32.465053, 5.07%) [median 656.127500]
   128k: 325.197067 (std. 7.963851, 2.45%) [median 326.575250]
   256k: 225.953933 (std. 5.467923, 2.42%) [median 225.228650]
   512k: 130.989550 (std. 0.400363, 0.31%) [median 131.112650]
   1m: 117.641500 (std. 0.186113, 0.16%) [median 117.718000]
   2m: 116.272483 (std. 0.151331, 0.13%) [median 116.329850]
   4m: 116.183633 (std. 0.090428, 0.08%) [median 116.176150]

bw_tcp:
   4k localhost: 182.479150 (std. 8.080340, 4.43%) [median 182.607500]
   8k localhost: 183.500150 (std. 11.904018, 6.49%) [median 185.972250]
   32k localhost: 197.045817 (std. 13.027870, 6.61%) [median 200.517000]
   64k localhost: 170.671217 (std. 17.970031, 10.53%) [median 164.683700]
   128k localhost: 134.142800 (std. 7.024478, 5.24%) [median 133.772400]
   512k localhost: 150.224233 (std. 8.241012, 5.49%) [median 151.932000]
   1m localhost: 138.914917 (std. 11.061916, 7.96%) [median 138.225950]

lat_connect:
   localhost: 59.166667 (std. 7.808115, 13.20%) [median 56.000000]

lat_tcp:
   localhost: 25.344150 (std. 0.074866, 0.30%) [median 25.360350]

lat_udp:
   localhost: 17.839750 (std. 0.145052, 0.81%) [median 17.807250]

lat_rpc:
   tcp localhost: 54.144133 (std. 0.097093, 0.18%) [median 54.173900]
   udp localhost: 38.389050 (std. 0.161139, 0.42%) [median 38.381350]

lat_fs:
   create 0: 349.124550 (std. 3.980803, 1.14%) [median 347.501450]
   delforw 0: 46.802733 (std. 16.296922, 34.82%) [median 46.450750]
   delrand 0: 448.240383 (std. 1.607562, 0.36%) [median 447.693900]
   delrev 0: 62.646967 (std. 1.308764, 2.09%) [median 62.220600]
   create 1024: 763.824200 (std. 3.690666, 0.48%) [median 763.124200]
   delforw 1024: 40.626617 (std. 0.658922, 1.62%) [median 40.560850]
   delrand 1024: 681.848433 (std. 268.485972, 39.38%) [median 609.828500]
   delrev 1024: 75.742650 (std. 1.124159, 1.48%) [median 75.729750]
   create 4096: 762.551450 (std. 3.062033, 0.40%) [median 763.013050]
   delforw 4096: 78.907867 (std. 2.229868, 2.83%) [median 78.649750]
   delrand 4096: 697.512967 (std. 112.102264, 16.07%) [median 734.636800]
   delrev 4096: 74.929817 (std. 1.093751, 1.46%) [median 74.534250]
   create 10240: 541.478100 (std. 5.516014, 1.02%) [median 539.486450]
   delforw 10240: 87.877183 (std. 4.962076, 5.65%) [median 87.444200]
   delrand 10240: 1118.024283 (std. 59.730340, 5.34%) [median 1131.545150]
   delrev 10240: 113.890300 (std. 2.060308, 1.81%) [median 113.798950]

lat_ctx:
   0k 2: 1.195917 (std. 0.011137, 0.93%) [median 1.195050]
   0k 4: 1.490933 (std. 0.024272, 1.63%) [median 1.494750]
   0k 8: 1.700417 (std. 0.020565, 1.21%) [median 1.699500]
   0k 16: 3.147867 (std. 0.042196, 1.34%) [median 3.142650]
   0k 20: 3.384950 (std. 0.037129, 1.10%) [median 3.384750]
   2k 2: 1.304733 (std. 0.033154, 2.54%) [median 1.311450]
   2k 4: 1.585650 (std. 0.021643, 1.36%) [median 1.580100]
   2k 8: 1.689133 (std. 0.020355, 1.21%) [median 1.691400]
   2k 16: 3.569967 (std. 0.038520, 1.08%) [median 3.568650]
   2k 20: 3.699050 (std. 0.053098, 1.44%) [median 3.708600]
   4k 2: 1.977700 (std. 0.022971, 1.16%) [median 1.984300]
   4k 4: 2.517433 (std. 0.028386, 1.13%) [median 2.516300]
   4k 8: 1.844617 (std. 0.105440, 5.72%) [median 1.788750]
   4k 16: 4.127633 (std. 0.126788, 3.07%) [median 4.165250]
   4k 20: 4.832400 (std. 0.237634, 4.92%) [median 4.732950]
   8k 2: 1.584917 (std. 0.035036, 2.21%) [median 1.592000]
   8k 4: 2.393950 (std. 0.028369, 1.19%) [median 2.403200]
   8k 8: 2.772217 (std. 0.083099, 3.00%) [median 2.735550]
   8k 16: 6.307883 (std. 0.322091, 5.11%) [median 6.381500]
   8k 20: 9.445600 (std. 0.435189, 4.61%) [median 9.492600]
   16k 2: 2.308150 (std. 0.031114, 1.35%) [median 2.317650]
   16k 4: 2.553833 (std. 0.058790, 2.30%) [median 2.533250]
   16k 8: 5.599583 (std. 0.272039, 4.86%) [median 5.571100]
   16k 16: 13.721850 (std. 0.383264, 2.79%) [median 13.651950]
   16k 20: 12.733717 (std. 0.537721, 4.22%) [median 12.679250]
   32k 2: 2.059500 (std. 0.002781, 0.14%) [median 2.059150]
   32k 4: 3.250683 (std. 1.026621, 31.58%) [median 2.943650]
   32k 8: 11.523267 (std. 0.657627, 5.71%) [median 11.528900]
   32k 16: 12.268300 (std. 0.046976, 0.38%) [median 12.256250]
   32k 20: 12.332750 (std. 0.129224, 1.05%) [median 12.357100]
   64k 2: 3.823600 (std. 1.724258, 45.10%) [median 3.121350]
   64k 4: 12.702633 (std. 1.419911, 11.18%) [median 12.866700]
   64k 8: 12.145183 (std. 0.144269, 1.19%) [median 12.116450]
   64k 16: 12.699500 (std. 0.133462, 1.05%) [median 12.651150]
   64k 20: 12.480550 (std. 0.327731, 2.63%) [median 12.500250]

lat_ctx2:
   0k 2: 1.240850 (std. 0.033177, 2.67%) [median 1.243900]
   0k 4: 1.518717 (std. 0.011792, 0.78%) [median 1.521350]
   0k 8: 1.708033 (std. 0.016093, 0.94%) [median 1.711300]
   0k 16: 3.113050 (std. 0.057279, 1.84%) [median 3.119200]
   0k 20: 3.703100 (std. 0.026577, 0.72%) [median 3.703150]
   2k 2: 1.194000 (std. 0.009707, 0.81%) [median 1.193900]
   2k 4: 1.480617 (std. 0.023441, 1.58%) [median 1.480550]
   2k 8: 1.689833 (std. 0.045043, 2.67%) [median 1.681850]
   2k 16: 3.539483 (std. 0.072770, 2.06%) [median 3.547600]
   2k 20: 3.697317 (std. 0.051067, 1.38%) [median 3.686000]
   4k 2: 1.900117 (std. 0.014706, 0.77%) [median 1.896200]
   4k 4: 2.353767 (std. 0.030226, 1.28%) [median 2.356700]
   4k 8: 2.820750 (std. 0.050061, 1.77%) [median 2.830400]
   4k 16: 5.311283 (std. 0.101904, 1.92%) [median 5.306550]
   4k 20: 4.889300 (std. 0.161299, 3.30%) [median 4.901700]
   8k 2: 2.454500 (std. 0.018302, 0.75%) [median 2.451200]
   8k 4: 3.448900 (std. 0.007246, 0.21%) [median 3.448850]
   8k 8: 4.070750 (std. 0.173761, 4.27%) [median 4.153450]
   8k 16: 7.350117 (std. 0.316585, 4.31%) [median 7.394050]
   8k 20: 11.275333 (std. 0.441855, 3.92%) [median 11.245650]
   16k 2: 4.245850 (std. 0.018008, 0.42%) [median 4.249650]
   16k 4: 4.527433 (std. 0.045730, 1.01%) [median 4.521800]
   16k 8: 7.962950 (std. 0.824659, 10.36%) [median 7.745450]
   16k 16: 30.375067 (std. 1.093422, 3.60%) [median 30.189600]
   16k 20: 40.656800 (std. 0.616058, 1.52%) [median 40.734000]
   32k 2: 2.004083 (std. 0.014151, 0.71%) [median 2.007950]
   32k 4: 4.085950 (std. 0.956484, 23.41%) [median 4.184200]
   32k 8: 53.824300 (std. 1.975330, 3.67%) [median 53.829350]
   32k 16: 86.079833 (std. 0.616777, 0.72%) [median 86.107800]
   32k 20: 86.951983 (std. 0.112925, 0.13%) [median 86.962550]
   64k 2: 2.337050 (std. 0.026589, 1.14%) [median 2.337650]
   64k 4: 79.716567 (std. 7.405708, 9.29%) [median 81.861750]
   64k 8: 164.044750 (std. 0.213092, 0.13%) [median 164.060550]
   64k 16: 164.663817 (std. 0.399808, 0.24%) [median 164.827350]
   64k 20: 164.031900 (std. 0.365309, 0.22%) [median 163.992450]


============================================ 

PAVAN KUMAR REDDY N.S. 
Sr.Software Engineer
Wipro Technologies
53/1, Hosur road, Madivala 
Bangalore - 68. 
Phone Off: +91-80-5502001-8 extn: 6087. 
      Res: +91-80-6685179
http://www.wipro.com/linux/

============================================  

------=_NextPartTM-000-0482c9cd-e82d-408d-ba80-5451d6c65bba
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

**************************Disclaimer**************************************************    
 
 Information contained in this E-MAIL being proprietary to Wipro Limited is 'privileged' 
and 'confidential' and intended for use only by the individual or entity to which it is 
addressed. You are notified that any use, copying or dissemination of the information 
contained in the E-MAIL in any manner whatsoever is strictly prohibited.

****************************************************************************************

------=_NextPartTM-000-0482c9cd-e82d-408d-ba80-5451d6c65bba--
